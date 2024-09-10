//
//  MainTab.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import SwiftUI

struct MainTab: View {    
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "square.grid.2x2")
                }
            
            DownloadScreen()
                .tabItem {
                    Label("Download", systemImage: "folder")
                }
            
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}



#Preview {
    MainTab()
}
