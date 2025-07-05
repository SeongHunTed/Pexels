//
//  ViewDidLoadModifier.swift
//  Pexels
//
//  Created by Hoon on 5/16/25.
//

import SwiftUI

extension View {
	func onLoad(_ action: @escaping () async -> Void) -> some View {
		modifier(ViewDidLoadModifier(completion: action))
	}
}

private struct ViewDidLoadModifier: ViewModifier {
	@State private var isLoaded: Bool = false
	let completion: () async -> Void
	
	func body(content: Content) -> some View {
		content
			.task {
				if isLoaded { return }
				isLoaded = true
				await completion()
			}
	}
}
