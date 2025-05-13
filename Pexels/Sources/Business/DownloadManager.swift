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
}
