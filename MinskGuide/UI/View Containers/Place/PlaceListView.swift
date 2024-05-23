import SwiftUI

struct PlaceListView: View {
    var placeType: [Place]
    var title: String
    
    var body: some View {
        List(placeType) { place in
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
        .navigationTitle(title)
    }
}
