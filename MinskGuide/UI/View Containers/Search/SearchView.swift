import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var searchResults: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search for destinations", text: $searchText)
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
                    ForEach(searchResults, id: \.self) { result in
                        NavigationLink(destination: Text("Details for \(result)")) {
                            Text(result)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Search")
        }
    }
    
    func performSearch() {
        searchResults = ["Result 1", "Result 2", "Result 3"].filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
}

#Preview {
    SearchView()
}

