//
//  Favourite.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 26/05/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Favourite: Codable, Identifiable {
    @DocumentID var id: String?
    var isPublic: Bool
    var placeID: Int
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var recommendation: String
    var userId: String
}

extension Favourite {
    static var empty: Favourite {
        Favourite(isPublic: false, placeID: 0, name: "", address: "", latitude: 0, longitude: 0, recommendation: "", userId: "")
    }
}
