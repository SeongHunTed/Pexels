//
//  PexelsMainView.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import SwiftUI

struct PexelsMainView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	@StateObject private var mainModelData = MainModelData()
	@State private var navigationPath = NavigationPath()
	@State private var page = 1
	
	private enum Const {
		static let minItemWidth: CGFloat = 200
		static let maxColumns: Int = 5
		static let horizontalSpacing: CGFloat = 16
		static let verticalSpacing: CGFloat = 8
		static let minThumbnailHeight: CGFloat = 150
		static let maxThumbnailHeight: CGFloat = 200
	}
	
	var body: some View {
		NavigationStack(path: $navigationPath) {
			GeometryReader { geometry in
				ScrollView {
					let columns = calculateColumns(for: geometry.size.width)
					let itemHeight = calculateItemHeight(for: geometry.size.width)
					
					LazyVGrid(
						columns: columns,
						spacing: Const.verticalSpacing
					) {
						ForEach(mainModelData.photos) { photo in
							if let thumbnailURL = URL(string: photo.src.medium) {
								PexelThumbnailView(
									url: thumbnailURL,
									height: itemHeight
								)
								.onTapGesture {
									navigationPath.append(photo)
								}
								.onAppear {
									mainModelData.loadNextPage(currentItem: photo)
								}
							}
						}
					}
					.padding(Const.horizontalSpacing)
				}
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

// MARK: Calculate Columns & Height
extension PexelsMainView {
	private func calculateColumns(for width: CGFloat) -> [GridItem] {
		let availableWidth = width - (Const.horizontalSpacing * 2)
		
		var numberOfColumns = max(2, Int(availableWidth / (Const.minItemWidth + Const.horizontalSpacing)))
		numberOfColumns = min(numberOfColumns, Const.maxColumns)
		
		return Array(repeating: GridItem(.flexible(), spacing: Const.horizontalSpacing), count: numberOfColumns)
	}
	
	private func calculateItemHeight(for width: CGFloat) -> CGFloat {
		let ratio = (width - (2 * Const.horizontalSpacing)) / Const.minItemWidth
		let height = max(Const.minThumbnailHeight, min(Const.maxThumbnailHeight, ratio * 100))
		
		return height
	}
}

// MARK: Child View
extension PexelsMainView {
	private struct PexelThumbnailView: View {
		let url: URL
		let height: CGFloat
		
		var body: some View {
			GeometryReader { geometry in
				AsyncImage(url: url) { image in
					image
						.resizable()
						.scaledToFit()
						.frame(maxWidth: geometry.size.width, maxHeight: height)
						.clipped()
				} placeholder: {
					Color.gray
						.frame(width: geometry.size.width, height: height)
				}
			}
			.frame(height: height)
		}
	}
}

#Preview {
	PexelsMainView()
}
