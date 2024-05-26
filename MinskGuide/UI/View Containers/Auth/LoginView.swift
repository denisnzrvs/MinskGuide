import SwiftUI
import Combine
import FirebaseAnalyticsSwift

private enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    private func signInWithEmailPassword() {
        Task {
            if await viewModel.signInWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        Spacer()
        VStack {
            Image("loginPicture")
                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .padding(.bottom, 20)
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Button(action: signInWithGoogle) {
                Text("Sign in with Google")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(alignment: .leading) {
                        Image("Google")
                            .frame(width: 30, alignment: .center)
                    }
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .buttonStyle(.bordered)
            .padding([.top, .bottom], 50)
            
        }
        .listStyle(.plain)
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
            LoginView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel())
    }
}
