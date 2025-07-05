//
//  Coordinator.swift
//  DeepLinkProject
//
//  Created by Hoon on 5/31/25.
//

import SwiftUI

public class Coordinator: ObservableObject {
    @Published public var selection: UUID = Tab.main.id
	@Published public var path: [UUID: NavigationPath] = [:]
	
	private var providers: [String: any NavigationDestinationProvidable] = [:]
	
	init() {
		tabs.forEach { tab in
			path[tab.id] = NavigationPath()
		}
	}
	
	public func addProvider(_ provider: some NavigationDestinationProvidable) {
		providers[type(of: provider).host] = provider
	}
	
	public func pushDestination(url: URL) {
		guard let host = url.host else { return }
		guard let provider = providers[host] else { return }
		guard let destination = provider.navigationDestination(url: url) else { return }
		
		var tabSelection: UUID {
			guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
				  let tabParameter = (urlComponents.queryItems?.first { $0.name == "tab" })?.value,
				  let tab = (tabs.first { $0.rawValue == tabParameter }) else {
                return selection
			}
			
			return tab.id
		}
		
		selection = tabSelection
		path[selection]?.append(destination)
	}
}
