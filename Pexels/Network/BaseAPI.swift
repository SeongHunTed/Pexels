//
//  BaseAPI.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation
import OSLog

protocol BaseAPI {
	var baseURL: String { get }
	var url: String { get }
	var domain: String? { get }
	var version: String? { get }
	var path: String { get }
	
	var additionalHeader: [String: String]? { get }
	
	var method: HTTPMethod { get }
	var queryItems: [URLQueryItem]? { get }
	
	var body: [String: Any]? { get }
	var multiPartBody: Data? { get }
	
	/**
	 HTTP rest api request
	 
	 - parameter response: decodable type
	 - parameter request: URLRequest
	 - returns: Model of specific response
	 */
	func request<Response: Decodable>(_ urlRequest: URLRequest, response: Response.Type) async throws -> Response
	
	/**
	 HTTP rest api request
	 
	 - parameter request: URLRequest
	 - returns: reponse data
	 */
	func request(_ urlRequest: URLRequest) async throws -> Data
	
	
	/**
	 HTTPURLResponse exception handler
	 
	 - parameter reponse: `HTTPURLResponse`
	 */
	func handleResponse(_ response: HTTPURLResponse) throws
}

// MARK: - Default Implementation

private let logger = Logger(subsystem: "Pexels", category: "Default")

extension BaseAPI {
	var url: String {
		var pathComponents = [baseURL]
		
		if let domain {
			pathComponents.append(domain)
		}
		
		if let version {
			pathComponents.append(version)
		}
		
		pathComponents.append(path)
		
		return pathComponents.joined(separator: "/")
	}
	
	var header: [String: String]? {
		APIConst.commonHeader.deepMerged(with: additionalHeader ?? [:])
	}
	
	var urlRequest: URLRequest? {
		guard var urlComponents = URLComponents(string: url) else {
			logger.error("url Request error: \(NetworkingError.invalidURL), url: \(url)")
			return nil
		}
		
		urlComponents.queryItems = queryItems
		guard let url = urlComponents.url else {
			logger.error("url Query error: \(NetworkingError.invalidQueryItems)")
			return nil
		}
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = method.rawValue
		urlRequest.allHTTPHeaderFields = header
		urlRequest.timeoutInterval = APIConst.timeout
		
		return urlRequest
	}
	
	func request() async throws -> Data {
		guard let urlRequest else { throw NetworkingError.invalidURL }
		return try await request(urlRequest)
	}
	
	func request<Response: Decodable>(_ response: Response.Type) async throws -> Response {
		guard let urlRequest else { throw NetworkingError.invalidURL }
		return try await request(urlRequest, response: response)
	}
	
	func request<Response: Decodable>(_ urlRequest: URLRequest, response: Response.Type) async throws -> Response {
		let responseData = try await request(urlRequest)
		return try JSONDecoder().decode(Response.self, from: responseData)
	}
	
	func request(_ urlRequest: URLRequest) async throws -> Data {
		var urlRequest = urlRequest
		let urlString = urlRequest.url?.absoluteString ?? "none"
		logger.debug("request url: \(urlString)")
		logger.debug("request header: \(urlRequest.allHTTPHeaderFields ?? [:])")
		logger.debug("request body: \(body ?? [:])")
		
		do {
			if let body = body {
				urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
			}
			
			let (data, response) = try await URLSession.shared.data(for: urlRequest)
			guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.invalidResponse(response) }
			
			do {
				try handleResponse(httpResponse)
			} catch {
				logger.error("url: \(urlString)\nerror data: \(String(decoding: data, as: UTF8.self))")
				throw error
			}
			
			logger.debug("url: \(urlString)\nrecv data: \(String(decoding: data, as: UTF8.self))")
			return data
		} catch {
			logger.error("api error: \(error)")
			throw error
		}
	}
	
	func handleResponse(_ response: HTTPURLResponse) throws {
		guard response.statusCode == 200 else { throw NetworkingError.invalidResponse(response) }
	}
}

extension BaseAPI {
	var queryItems: [URLQueryItem]? { nil }
	var additionalHeader: [String: String]? { nil }
	var domain: String? { nil }
	var version: String? { nil }
	var body: [String: Any]? { nil }
	var multiPartBody: Data? { nil }
}

enum NetworkingError: Error {
	case invalidURL
	case invalidQueryItems
	case invalidResponse(_ response: URLResponse)
}
