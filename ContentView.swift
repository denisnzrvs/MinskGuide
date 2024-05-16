import SwiftUI

struct ContentView: View {
    @StateObject private var tabController = Tabs()
    @ObservedObject var viewModel = ViewModel()
    
        var body: some View {
            TabView(selection: $tabController.activeTab) {
                // MARK: Profile View
                ProfileView(viewModel: viewModel)
                    .tag(Tab.profile)
                    .tabItem { Label("", systemImage: "person") }
                // MARK: Favorite View
                FavoriteView(viewModel: viewModel)
                    .tag(Tab.favorite)
                    .tabItem { Label("", systemImage: "heart") }
                // MARK: Search View
                SearchView(viewModel: viewModel)
                    .tag(Tab.search)
                    .tabItem { Label("", systemImage: "search") }
                // MARK: Settings View
                SettingsView(viewModel: viewModel)
                    .tag(Tab.settings)
                    .tabItem { Label("", systemImage: "settings") }
            }
            .environmentObject(tabController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
