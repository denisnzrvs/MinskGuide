import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var showCategoryCards = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Image("HeroBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(40)
                    .clipped()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) { // Fade-in animation
                            showCategoryCards = true
                        }
                    }

                if showCategoryCards {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            NavigationLink(destination: PlaceListView(placeType: viewModel.restaurants, title: "Restaurants")) {
                                categoryCard(title: "Restaurants", imageName: "restaurantsImage")
                                    .scaleEffect(1.0) // Initial scale
                                    .onAppear {
                                        withAnimation(.spring()) { // Scale animation
                                            // Empty onAppear block to trigger animation
                                        }
                                    }
                            }
                            NavigationLink(destination: PlaceListView(placeType: viewModel.museums, title: "Museums")) {
                                categoryCard(title: "Museums", imageName: "museumsImage")
                                    .scaleEffect(1.0)
                                    .onAppear {
                                        withAnimation(.spring()) {
                                            // Empty onAppear block to trigger animation
                                        }
                                    }
                            }
                            NavigationLink(destination: PlaceListView(placeType: viewModel.hotels, title: "Hotels")) {
                                categoryCard(title: "Hotels", imageName: "hotelsImage")
                                    .scaleEffect(1.0)
                                    .onAppear {
                                        withAnimation(.spring()) {
                                            // Empty onAppear block to trigger animation
                                        }
                                    }
                            }
                            NavigationLink(destination: PlaceListView(placeType: viewModel.shops, title: "Shops")) {
                                categoryCard(title: "Shops", imageName: "shopsImage")
                                    .scaleEffect(1.0)
                                    .onAppear {
                                        withAnimation(.spring()) {
                                            // Empty onAppear block to trigger animation
                                        }
                                    }
                            }
                        }
                        .padding()
                        .transition(.opacity) // Fade-in transition
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
