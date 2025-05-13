//
//  MainModelData.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation
import Combine

final class MainModelData: ObservableObject {
	@Published var photos: [Photo] = []
	
	private let downloadManager = DownloadManager()
	private var cancellables: Set<AnyCancellable> = []
	
	func fetchImages(page: Int) {
		downloadManager.downloadCurations(page: page)
			.receive(on: DispatchQueue.main)
			.sink { completion in
				switch completion {
					case .finished:
						break
					case .failure(let error):
						print("Error: \(error)")
				}
			} receiveValue: { curation in
				self.photos.append(contentsOf: curation.photos)
			}
			.store(in: &cancellables)
	}
}
