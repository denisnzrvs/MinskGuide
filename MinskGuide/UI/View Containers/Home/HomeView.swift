import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.places.isEmpty {
                    List {
                        NavigationLink(destination: PlaceListView(placeType: viewModel.restaurants, title: "Restaurants")) {
                            Text("Restaurants")
                        }
                        NavigationLink(destination: PlaceListView(placeType: viewModel.museums, title: "Museums")) {
                            Text("Museums")
                        }
                        NavigationLink(destination: PlaceListView(placeType: viewModel.hotels, title: "Hotels")) {
                            Text("Hotels")
                        }
                        NavigationLink(destination: PlaceListView(placeType: viewModel.shops, title: "Shops")) {
                            Text("Shops")
                        }
                        
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationTitle("Places")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
