import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @StateObject var homeViewModel = HomeViewModel()

    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.authenticationState == .unauthenticated {
                    Spacer()
                    LoginView(viewModel: viewModel)
                    Spacer()
                } else {
                    Text("Welcome! You are logged in.")
                    
                }
            }
            .navigationTitle("Home")
            .onAppear {
                viewModel.registerAuthStateHandler()
                homeViewModel.loadData()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
