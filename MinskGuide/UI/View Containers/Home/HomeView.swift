import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Displaying the HeroBanner image
                Image("HeroBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                
                if !viewModel.places.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            NavigationLink(destination: PlaceListView(placeType: viewModel.restaurants, title: "Restaurants")) {
                                categoryCard(title: "Restaurants", imageName: "restaurantsImage")
                            }
                            NavigationLink(destination: PlaceListView(placeType: viewModel.museums, title: "Museums")) {
                                categoryCard(title: "Museums", imageName: "museumsImage")
                            }
                            NavigationLink(destination: PlaceListView(placeType: viewModel.hotels, title: "Hotels")) {
                                categoryCard(title: "Hotels", imageName: "hotelsImage")
                            }
                            NavigationLink(destination: PlaceListView(placeType: viewModel.shops, title: "Shops")) {
                                categoryCard(title: "Shops", imageName: "shopsImage")
                            }
                        }
                        .padding()
                    }
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
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
    
    private func categoryCard(title: String, imageName: String) -> some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white.opacity(0.3)]), startPoint: .bottom, endPoint: .top)
                )
                .cornerRadius(12)
                .shadow(radius: 5)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.opacity(0.5))
                .cornerRadius(8)
        }
        .padding(4)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
