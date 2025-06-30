//
//  PexelTabView.swift
//  Pexels
//
//  Created by Hoon on 5/14/25.
//

import SwiftUI

struct PexelTabView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $coordinator.selection) {
                PexelsMainView()
                    .tag(Tab.main.id)
                
                FavoriteView()
                    .tag(Tab.favorite.id)
                
                MyPageView()
                    .tag(Tab.mypage.id)
            }
            
            TabBar(tabID: $coordinator.selection)
        }
    }
}

#Preview {
    PexelTabView()
}
