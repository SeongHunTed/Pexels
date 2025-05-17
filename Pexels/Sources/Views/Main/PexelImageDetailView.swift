//
//  PexelImageDetailView.swift
//  Pexels
//
//  Created by Hoon on 5/14/25.
//

import SwiftUI

struct PexelImageDetailView: View {
	let photo: Photo
	
    var body: some View {
		VStack {
			if let url = URL(string: photo.src.large) {
				AsyncImage(url: url) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
				} placeholder: {
					ProgressView()
				}
			}
			
			Text("Photographer: \(photo.photographer)")
				.font(.headline)
				.padding(.top)
			
			Spacer()
		}
		.padding()
		.navigationTitle(photo.alt)
		.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
	let photo = Photo(
		id: 32021762,
		width: 4284,
		height: 5712,
		url: "https://www.pexels.com/photo/fresh-red-strawberries-soaked-in-water-for-cleaning-32021762/",
		photographer: "Mar Andr",
		photographerURL: "https://www.pexels.com/@mar-andr-230382192",
		photographerID: 230382192,
		avgColor: "#9B392C",
		src: Src(
			original: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg",
			large2X: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
			large: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
			medium: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&h=350",
			small: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&h=130",
			portrait: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
			landscape: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
			tiny: "https://images.pexels.com/photos/32021762/pexels-photo-32021762.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
		),
		liked: false,
		alt: "strawberries"
	)
    PexelImageDetailView(photo: photo)
}
