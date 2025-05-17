//
//  PexelTabType.swift
//  Pexels
//
//  Created by Hoon on 5/14/25.
//

import Foundation

enum PexelTabType: CaseIterable {
	case main
	case favorite
	case mypage
	
	var display: String {
		switch self {
			case .main:
				return "홈"
			case .favorite:
				return "즐겨찾기"
			case .mypage:
				return "마이"
		}
	}
	
	var imageName: String {
		switch self {
			case .main:
				return "house"
			case .favorite:
				return "star"
			case .mypage:
				return "person"
		}
	}
}
