//
//  PlaceDetailsView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 23/05/2024.
//

import SwiftUI
import MapKit

struct PlaceDetailsView: View {
    var place: Place
    var body: some View {
        NavigationStack() {
            VStack {
                Spacer()
                Text(place.name)
                Text(place.address)
                Text(place.recommendation)
                Map() {
                    Marker(place.name, coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude))
                }
                .frame(width: .infinity, height: 250, alignment: .bottom)
                .padding(15)
            }
            .navigationTitle(Text(place.name))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

