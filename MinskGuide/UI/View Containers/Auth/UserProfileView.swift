import SwiftUI
import FirebaseAnalyticsSwift

struct UserProfileView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false
    @State var profileImage: UIImage? // State variable to hold the selected profile image
    @State private var isShowingImagePicker = false // State variable to control the presentation of the image picker

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
                ZStack {
                    // Display the profile image
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 100, height: 100)
                    }
                    Button(action: {
                        isShowingImagePicker.toggle()
                    }) {
                        Text("Edit")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .offset(x: 30, y: 30) // Adjust the button position
                }
                .frame(maxWidth: .infinity) // Take the whole width
                .padding(.horizontal) // Add horizontal padding
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
        .sheet(isPresented: $isShowingImagePicker) {
            // Present the image picker as a sheet
            ImagePicker(image: $profileImage)
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
