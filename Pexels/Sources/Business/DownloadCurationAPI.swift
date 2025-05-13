//
//  DownloadCurationAPI.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation
import Network

enum DownloadCurationAPI: BaseAPI {
	case downloadCuration(page: Int)
	
	var baseURL: String { "https://api.pexels.com" }
	var version: String? { "v1" }
	var path: String { "curated" }
	var method: HTTPMethod  { .get }
	var additionalHeader: [String : String]? {
		["Authorization": "\(AppConfig.apiKey)"]
	}
	
	var queryItems: [URLQueryItem]? {
		switch self {
		case let .downloadCuration(page):
			[URLQueryItem(name: "page", value: "\(page)")]
		}
	}
}
