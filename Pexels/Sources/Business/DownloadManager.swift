//
//  DownloadManager.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation
import Combine
import OSLog

private let logger = Logger(subsystem: "Pexels", category: "DownloadManager")

final class DownloadManager {
	func downloadCurations(page: Int) -> AnyPublisher<Curation, Error> {
		Future { promise in
			Task {
				do {
					let recvData = try await DownloadCurationAPI.downloadCuration(page: page).request(Curation.self)
					logger.debug("curation complete response data: \(String(describing: recvData))")
					promise(.success(recvData))
				} catch {
					logger.error("curation complete request error: \(error.localizedDescription)")
					promise(.failure(error))
				}
			}
		}
		.eraseToAnyPublisher()
	}
	
	func downloadCurations(from urlString: String) -> AnyPublisher<Curation, Error> {
		guard
			let url = URL(string: urlString),
			let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
			let pageString = components.queryItems?.first(where: { $0.name == "page" })?.value,
			let page = Int(pageString)
		else {
			logger.error("Invalid next_page URL: \(urlString)")
			return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
		}
		
		return downloadCurations(page: page)
	}
}
