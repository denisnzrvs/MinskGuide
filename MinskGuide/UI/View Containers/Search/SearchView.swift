import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var searchResults: [Place] = []
    @EnvironmentObject var homeViewModel: HomeViewModel

    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search for destinations", text: $searchText, onCommit: performSearch)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                    
                    Button(action: {
                        performSearch()
                    }) {
                        Text("Search")
                            .foregroundColor(.white)
                            .padding(7)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 10)
                }
                .padding(.top, 10)
                
                List {
                    ForEach(searchResults) { place in
                        NavigationLink(destination: PlaceDetailsView(place: place)) {
                            PlaceCardView(place: place)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Search")
        }
        .onAppear {
            
            searchResults = homeViewModel.places
        }
    }
    
    func performSearch() {
        searchResults = homeViewModel.places.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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


