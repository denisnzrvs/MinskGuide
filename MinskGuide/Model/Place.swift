//
//  Place.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 23/05/2024.
//

import Foundation

class Place: Identifiable {
    var id: Int
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var recommendation: String
    
    init(id: Int, name: String, address: String, latitude: Double, longitude: Double, recommendation: String) {
        self.id = id
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.recommendation = recommendation
    }
}
