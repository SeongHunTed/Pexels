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
	
	private(set) var nextPageURL: String?
	
	func fetchInitialImages(page: Int) {
		downloadManager.downloadCurations(page: page)
			.receive(on: DispatchQueue.main)
			.sink { completion in
				if case .failure(let error) = completion {
					print("Error: \(error)")
				}
			} receiveValue: { [weak self] curation in
				self?.photos = curation.photos
				self?.nextPageURL = curation.nextPage
			}
			.store(in: &cancellables)
	}
	
	func loadNextPage(currentItem item: Photo) {
		guard let nextPageURL else { return }
		guard let thresholdItem = photos.suffix(5).first else { return }
		if thresholdItem.id == item.id {
			fetchNextPage(from: nextPageURL)
		}
	}
	
	private func fetchNextPage(from url: String) {
		downloadManager.downloadCurations(from: url)
			.receive(on: DispatchQueue.main)
			.sink { completion in
				if case .failure(let error) = completion {
					print("Error: \(error)")
				}
			} receiveValue: { [weak self] curation in
				self?.photos.append(contentsOf: curation.photos)
				self?.nextPageURL = curation.nextPage
			}
			.store(in: &cancellables)
	}
}
