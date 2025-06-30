//
//  TabBar.swift
//  Pexels
//
//  Created by tedios on 6/30/25.
//

import SwiftUI

struct TabBar: View {
    enum Const {
        static let selectedColor = Color.purple
        static let defaultColor = Color.gray
        static let vStackSpace: CGFloat = 4
        static let tabBarHeight: CGFloat = 70
    }
    
    @Binding var tabID: UUID
    
    var body: some View {
        HStack {
            ForEach(tabs) { tab in
                VStack(spacing: Const.vStackSpace) {
                    Image(systemName: tab.id == tabID ? tab.selectedImageName : tab.imageName)
                    Text(tab.name)
                }
                .foregroundStyle(tab.id == tabID ? Const.selectedColor : Const.defaultColor)
                .contentShape(Rectangle())
                .onTapGesture {
                    tabID = tab.id
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: Const.tabBarHeight)
        .background(.white)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: -2)
    }
}
