//
//  PexelsMainView.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import SwiftUI

struct PexelsMainView: View {
	@StateObject private var mainModelData = MainModelData()
	@State private var page = 1
	
	private let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 8) {
				ForEach(mainModelData.photos, id: \.id) { photo in
					if let url = URL(string: photo.src.medium) {
						AsyncImage(url: url) { image in
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
								.clipped()
						} placeholder: {
							Color.gray
						}
						.frame(height: 150)
						.cornerRadius(8)
					}
				}
			}
			.padding()
		}
		.onAppear {
			mainModelData.fetchImages(page: 1)
		}
	}
}

#Preview {
    PexelsMainView()
}
