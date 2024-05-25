import SwiftUI
import MapKit

struct PlaceDetailsView: View {
    var place: Place
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(place.name)
                    .font(.largeTitle)
                    .bold()
                
                Text(place.address)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 16) {
                    Button(action: {
                        openInMaps()
                    }) {
                        Text("Let's drive!")
                            .padding()
                            .foregroundColor(.blue)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        isFavorite.toggle()
                        //saveFavoriteStatus() //save favorite places to user repository
                    }) {
                        HStack {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .yellow : .gray)
                            Text(isFavorite ? "Unfavorite" : "Add to Favorites")
                        }
                        .padding()
                        .foregroundColor(.blue)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                    }
                }
                .padding(.top, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recommendation:")
                        .font(.headline)
                    
                    Text(place.recommendation)
                        .font(.body)
                }
                .padding(.top, 8)
                
                Spacer() // Pushes content to the top
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Ensures alignment to the left
            .navigationTitle(Text(place.name))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func openInMaps() {
        let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    PlaceDetailsView(place: Place(id: 1, name: "Miraz", address: "Vulitsa Whatever", latitude: 0.19282, longitude: 0.29812, recommendation: "I'm lovin' it!"))
}
