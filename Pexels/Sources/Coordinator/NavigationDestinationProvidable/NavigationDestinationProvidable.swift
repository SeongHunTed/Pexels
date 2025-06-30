//
//  NavigationDestinationProvidable.swift
//  DeepLinkProject
//
//  Created by Hoon on 5/31/25.
//

import SwiftUI

public protocol NavigationDestinationProvidable {
	associatedtype Destination: Hashable
	associatedtype NavigationDestinationView: View
	
	static var host: String { get }
	func navigationDestinationView(type: Destination) -> NavigationDestinationView
	func navigationDestination(url: URL) -> Destination?
}

protocol NavigationDestinationViewModifiable: ViewModifier {
	associatedtype Provider: NavigationDestinationProvidable
	var provider: Provider { get }
}

public struct NavigationDestinationViewModifier<Provider: NavigationDestinationProvidable>: NavigationDestinationViewModifiable {
	@EnvironmentObject private var coordinator: Coordinator
	
	let provider: Provider
	
	init(provider: Provider) {
		self.provider = provider
	}
	
	public func body(content: Content) -> some View {
		content
			.onLoad {
				coordinator.addProvider(provider)
			}
			.navigationDestination(
				for: type(of: provider).Destination.self,
				destination: provider.navigationDestinationView
			)
	}
}
