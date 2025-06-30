//
//  PexelTabType.swift
//  Pexels
//
//  Created by Hoon on 5/14/25.
//

import Foundation

let tabs = Tab.allCases

enum Tab: String, CaseIterable, Hashable, Identifiable {
	case main
	case favorite
	case mypage
    
    var id: UUID {
        uuid
    }
	
	var name: String {
		switch self {
			case .main: return "홈"
			case .favorite: return "즐겨찾기"
			case .mypage: return "마이"
		}
	}
    
    var selectedImageName: String {
        switch self {
        case .main: return "house.fill"
        case .favorite: return "star.fill"
        case .mypage: return "person.fill"
        }
    }
	
	var imageName: String {
		switch self {
			case .main: return "house"
			case .favorite: return "star"
			case .mypage: return "person"
		}
	}
    
    private var uuid: UUID {
        switch self {
        case .main: return Self.uuidMap[.main]!
        case .favorite: return Self.uuidMap[.favorite]!
        case .mypage: return Self.uuidMap[.mypage]!
        }
    }
    
    private static let uuidMap: [Tab: UUID] = [
        .main: UUID(),
        .favorite: UUID(),
        .mypage: UUID()
    ]
}
