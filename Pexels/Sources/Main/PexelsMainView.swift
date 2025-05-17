//
//  PexelsMainView.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import SwiftUI

struct PexelsMainView: View {
	@StateObject private var mainModelData = MainModelData()
	@State private var navigationPath = NavigationPath()
	@State private var page = 1
	
	private let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		NavigationStack(path: $navigationPath) {
			ScrollView {
				LazyVGrid(columns: columns, spacing: 8) {
					ForEach(mainModelData.photos, id: \.id) { photo in
						if let thumbnailURL = URL(string: photo.src.medium) {
							NavigationLink(value: photo) {
								PexelThumbnailView(url: thumbnailURL)
									.onAppear {
										mainModelData.fetchNextPageIfNeeded(currentItem: photo)
									}
							}
						}
					}
				}
				.padding()
			}
			.navigationDestination(for: Photo.self) { photo in
				PexelImageDetailView(photo: photo)
			}
			.onLoad {
				mainModelData.fetchInitialImages(page: 1)
			}
		}
	}
}

extension PexelsMainView {
	private struct PexelThumbnailView: View {
		let url: URL
		
		var body: some View {
			GeometryReader { geometry in
				AsyncImage(url: url) { image in
					image
						.resizable()
						.scaledToFit()
						.frame(maxWidth: geometry.size.width, maxHeight: 150)
						.clipped()
				} placeholder: {
					Color.gray
						.frame(width: geometry.size.width, height: 150)
				}
			}
			.frame(height: 150)
			.cornerRadius(8)
		}
	}
}

#Preview {
    PexelsMainView()
}
