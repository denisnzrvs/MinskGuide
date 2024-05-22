//
//  SettingsView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack() {
            VStack() {
            
                    UserProfileView()
                }
            
            .navigationTitle("Settings")
        }
        
        .onAppear {
            authViewModel.registerAuthStateHandler()
        }
    }
    
}

#Preview {
    SettingsView()
}
