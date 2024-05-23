import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) { // Set spacing to 0 to remove any extra space
                // Displaying the HeroBanner image
                Image("HeroBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped() // Ensure the image is clipped to its frame
                
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
                    .padding(.top, -8) // Adjust top padding to remove extra space
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
            .edgesIgnoringSafeArea([.top, .bottom]) // Ignore safe area for the bottom edge
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
