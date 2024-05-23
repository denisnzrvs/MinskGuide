import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.places.isEmpty {
                    List(viewModel.places) { place in
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
