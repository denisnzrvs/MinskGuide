//  HomeView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.authenticationState == .unauthenticated {
                VStack {
                    Spacer()
                    LoginView(viewModel: viewModel)
                    Spacer()
                }
            } else {
                VStack {
                    Text("Welcome! You are logged in.")
                }
                .navigationTitle("Home")
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


