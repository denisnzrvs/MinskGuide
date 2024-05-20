//
//  RootView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var tabController = TabController()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem { Label("Home", systemImage: "person.fill") }
            FavoritesView()
                .tag(Tab.favorites)
                .tabItem { Label("Favorites", systemImage: "photo") }
            SettingsView()
                .tag(Tab.settings)
                .tabItem { Label("Settings", systemImage: "video.fill")}
        }
    }
}
