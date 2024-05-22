//  HomeView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//
import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello")
                    .navigationTitle("Home")
                
                if viewModel.authenticationState == .unauthenticated {
                    LoginView(viewModel: viewModel)
                } else {
                    AuthenticatedView {
                        // Custom content for authenticated users
                        Text("Welcome! You are logged in.")
                    }
                }
            }
        }
        .onAppear {
            viewModel.registerAuthStateHandler()
        }
    }
}

#Preview {
    HomeView()
}
