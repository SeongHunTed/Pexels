//
//  View+Extensions.swift
//  DeepLinkProject
//
//  Created by Hoon on 5/31/25.
//

import SwiftUI

extension View {
	func addNavigationDestinationProvider<Provider: NavigationDestinationProvidable>(_ provider: Provider) -> some View {
		modifier(NavigationDestinationViewModifier(provider: provider))
	}
}
