//
//  RootView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var tabController = TabController()
    @StateObject private var authViewModel =  AuthenticationViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        Group {
            if authViewModel.authenticationState == .authenticated {
                TabView(selection: $tabController.activeTab) {
                    HomeView()
                        .tag(Tab.home)
                        .tabItem { Label("Home", systemImage: "house") }
                    SearchView()
                        .environmentObject(homeViewModel)
                        .tag(Tab.search)
                        .tabItem { Label("Search", systemImage: "magnifyingglass") }
                    FavoritesView()
                        .tag(Tab.favorites)
                        .tabItem { Label("Favorites", systemImage: "star") }
                    SettingsView()
                        .tag(Tab.settings)
                        .tabItem { Label("Settings", systemImage: "gearshape") }
                }
            } else {
                LoginView(viewModel: authViewModel)
            }
        }
        .onAppear {
            authViewModel.registerAuthStateHandler()
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthenticationViewModel()) // Provide a mock authViewModel for preview
}
