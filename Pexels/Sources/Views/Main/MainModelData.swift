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
	private var isLoading = false
	
	func fetchInitialImages(page: Int) {
		isLoading = true
		
		downloadManager.downloadCurations(page: page)
			.receive(on: DispatchQueue.main)
			.sink { [weak self] completion in
				self?.isLoading = false
				if case .failure(let error) = completion {
					print("Error: \(error)")
				}
			} receiveValue: { [weak self] curation in
				self?.photos = curation.photos
				self?.nextPageURL = curation.nextPage
			}
			.store(in: &cancellables)
	}
	
	func fetchNextPageIfNeeded(currentItem item: Photo) {
		guard let nextPageURL, !isLoading else { return }
		guard let thresholdItem = photos.suffix(5).first else { return }
		if thresholdItem.id == item.id {
			fetchNextPage(from: nextPageURL)
		}
	}
	
	private func fetchNextPage(from url: String) {
		isLoading = true
		
		downloadManager.downloadCurations(from: url)
			.receive(on: DispatchQueue.main)
			.sink { [weak self] completion in
				self?.isLoading = false
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
