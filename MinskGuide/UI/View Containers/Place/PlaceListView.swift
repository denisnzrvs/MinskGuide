import SwiftUI

struct PlaceListView: View {
    @State var placeType: [Place]
    var title: String
    
    var body: some View {
        List($placeType) { $place in
            NavigationLink(destination: PlaceDetailsView(place: place)) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(place.name)
                            .font(.headline)
                     /*   if place.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        } */
                    }
                    Text(place.address)
                        .foregroundColor(.secondary)
                    Text(place.recommendation)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .padding(.top)
                }
                              .padding(.vertical, 8)
                          }
                      }
                      .navigationTitle(title)
                  }
              }
