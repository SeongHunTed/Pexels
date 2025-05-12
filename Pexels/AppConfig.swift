//
//  AppConfig.swift
//  Pexels
//
//  Created by Hoon on 5/11/25.
//

import Foundation

enum AppConfig {
	static let apiKey = Bundle.main.infoDictionary?["APIKey"] as? String ?? ""
}
