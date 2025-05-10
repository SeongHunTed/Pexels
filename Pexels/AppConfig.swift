//
//  AppConfig.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation

enum AppConfig {
	static let apiKey = Bundle.main.infoDictionary?["APIKey"] as! String
}
