//
//  FavoritesView.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class FavouritesListViewModel: ObservableObject {
    @Published var favourites = [Favourite]()
    @Published var errorMessage: String?
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    public func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("favourites")
                .whereField("isPublic", isEqualTo: true)
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        self?.errorMessage = "No documents in 'favourites' collection"
                        return
                    }
                    
                    self?.favourites = documents.compactMap { queryDocumentSnapshot in
                        let result = Result { try queryDocumentSnapshot.data(as: Favourite.self) }
                        
                        switch result {
                            case .success(let favourite):
                                self?.errorMessage = nil
                                return favourite
                            case .failure(let error):
                                // A Favourite value could not be initialized from the DocumentSnapshot.
                                switch error {
                                    case DecodingError.typeMismatch(_, let context):
                                        self?.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                                    case DecodingError.valueNotFound(_, let context):
                                        self?.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                                    case DecodingError.keyNotFound(_, let context):
                                        self?.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                                    case DecodingError.dataCorrupted(let key):
                                        self?.errorMessage = "\(error.localizedDescription): \(key)"
                                    default:
                                        self?.errorMessage = "Error decoding document: \(error.localizedDescription)"
                                }
                                return nil
                        }
                    }
                }
        }
    }
}


struct FavouritesView: View {
    @StateObject var viewModel = FavouritesListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.favourites) { item in
                VStack(alignment: .leading) {
                    Text("Place ID: \(item.placeID)")
                }
            }
            .navigationTitle("All Favourites")
            .onAppear {
                viewModel.subscribe()
            }
            .onDisappear {
                viewModel.unsubscribe()
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
