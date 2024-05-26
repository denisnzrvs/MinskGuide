import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var searchResults: [Place] = []
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Image("SearchImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(40)
                    .clipped()
                    .edgesIgnoringSafeArea([.top, .bottom])
                
                VStack(spacing: 0) {
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    HStack {
                        TextField("Search for destinations", text: $searchText, onCommit: performSearch)
                            .padding(7)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                            .padding(.horizontal, 10)
                        
                        Button(action: {
                            performSearch()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(7)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                        .padding(.trailing, 10)
                    }
                    .padding()
                }
                .background(Color.white) // Set background color to avoid transparency over the image
                .padding(.top, -50)
                
                List {
                    ForEach(searchResults) { place in
                        NavigationLink(destination: PlaceDetailsView(place: place)) {
                            PlaceCardView(place: place)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            searchResults = homeViewModel.places
        }
    }
    
    func performSearch() {
        withAnimation {
            searchResults = homeViewModel.places.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct PlaceCardView: View {
    let place: Place
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(place.name)
                .font(.headline)
            Text(place.address)
                .foregroundColor(.secondary)
            Text(place.recommendation)
                .foregroundColor(.secondary)
                .font(.footnote)
                .padding(.top, 4)
        }
        .padding(.vertical, 8)
    }
}
