//
//  PexelTabView.swift
//  Pexels
//
//  Created by Hoon on 5/14/25.
//

import SwiftUI

struct PexelTabView: View {
    var body: some View {
		TabView {
			PexelsMainView()
				.tabItem {
					Label(PexelTabType.main.display, systemImage: PexelTabType.main.imageName)
				}
			
			FavoriteView()
				.tabItem {
					Label(PexelTabType.favorite.display, systemImage: PexelTabType.favorite.imageName)
				}
			
			MyPageView()
				.tabItem {
					Label(PexelTabType.mypage.display, systemImage: PexelTabType.mypage.imageName)
				}
		}
		.tint(.purple)
    }
}

#Preview {
    PexelTabView()
}
