//
//  DownloadCurationResponse.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation

struct Curation: Decodable {
	let page, perPage: Int
	let photos: [Photo]
	let nextPage: String
	
	enum CodingKeys: String, CodingKey {
		case page
		case perPage = "per_page"
		case photos
		case nextPage = "next_page"
	}
}

struct Photo: Decodable, Identifiable {
	let id, width, height: Int
	let url: String
	let photographer: String
	let photographerURL: String
	let photographerID: Int
	let avgColor: String
	let src: Src
	let liked: Bool
	let alt: String
	
	enum CodingKeys: String, CodingKey {
		case id, width, height, url, photographer
		case photographerURL = "photographer_url"
		case photographerID = "photographer_id"
		case avgColor = "avg_color"
		case src, liked, alt
	}
}

struct Src: Decodable {
	let original, large2X, large, medium: String
	let small, portrait, landscape, tiny: String
	
	enum CodingKeys: String, CodingKey {
		case original
		case large2X = "large2x"
		case large, medium, small, portrait, landscape, tiny
	}
}
