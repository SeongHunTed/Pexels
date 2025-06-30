//
//  PexelsApp.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import SwiftUI

@main
struct PexelsApp: App {
    @StateObject private var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            PexelTabView()
                .environmentObject(coordinator)
        }
    }
}
