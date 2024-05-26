//
//  UserProfileView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 22/05/2024.
//

import SwiftUI
import FirebaseAnalyticsSwift

struct UserProfileView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false
    
    private func deleteAccount() {
        Task {
            if await viewModel.deleteAccount() == true {
                dismiss()
            }
        }
    }
    
    private func signOut() {
        viewModel.signOut()
    }
    
    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                    }
                    Button(action: {}) {
                        Text("edit")
                    }
                }
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
            Section("Email") {
                Text(viewModel.displayName)
            }
            Section {
                Button(role: .cancel, action: signOut) {
                    HStack {
                        Spacer()
                        Text("Sign out")
                        Spacer()
                    }
                }
            }
            Section {
                Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                    HStack {
                        Spacer()
                        Text("Delete Account")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                            isPresented: $presentingConfirmationDialog) {
            Button("Delete Account", role: .destructive, action: deleteAccount)
            Button("Cancel", role: .cancel, action: { })
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserProfileView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}
