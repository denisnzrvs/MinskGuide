import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    private var placesRepo = PlacesRepository()
    @Published var places: [Place] = []
    @Published var errorMessage: String?
    
    init() {
        loadData()
    }
    
    func loadData() {
        placesRepo.downloadFileFromGitHub { result in
            switch result {
                case .success(let contents):
                    // Parse JSON data
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: contents.data(using: .utf8)!, options: []) as! [String: Any]
                        guard let placesData = jsonData["places"] as? [String: [[String: Any]]] else {
                            self.errorMessage = "Invalid JSON structure"
                            return
                        }
                        
                        var placesArray: [Place] = []
                        
                        // Parse restaurants
                        if let restaurants = placesData["restaurants"] {
                            for restaurant in restaurants {
                                if let id = restaurant["id"] as? Int,
                                   let name = restaurant["name"] as? String,
                                   let address = restaurant["address"] as? String,
                                   let latitude = restaurant["latitude"] as? Double,
                                   let longitude = restaurant["longitude"] as? Double,
                                   let recommendation = restaurant["recommendation"] as? String {
                                    
                                    let place = Place(id: id, name: name, address: address, latitude: latitude, longitude: longitude, recommendation: recommendation)
                                    placesArray.append(place)
                                }
                            }
                        }
                        
                        // Parse museums
                        if let museums = placesData["museums"] {
                            for museum in museums {
                                if let id = museum["id"] as? Int,
                                   let name = museum["name"] as? String,
                                   let address = museum["address"] as? String,
                                   let latitude = museum["latitude"] as? Double,
                                   let longitude = museum["longitude"] as? Double,
                                   let recommendation = museum["recommendation"] as? String {
                                    
                                    let place = Place(id: id, name: name, address: address, latitude: latitude, longitude: longitude, recommendation: recommendation)
                                    placesArray.append(place)
                                }
                            }
                        }
                        
                        // Parse hotels
                        if let hotels = placesData["hotels"] {
                            for hotel in hotels {
                                if let id = hotel["id"] as? Int,
                                   let name = hotel["name"] as? String,
                                   let address = hotel["address"] as? String,
                                   let latitude = hotel["latitude"] as? Double,
                                   let longitude = hotel["longitude"] as? Double,
                                   let recommendation = hotel["recommendation"] as? String {
                                    
                                    let place = Place(id: id, name: name, address: address, latitude: latitude, longitude: longitude, recommendation: recommendation)
                                    placesArray.append(place)
                                }
                            }
                        }
                        
                        // Parse shops
                        if let shops = placesData["shops"] {
                            for shop in shops {
                                if let id = shop["id"] as? Int,
                                   let name = shop["name"] as? String,
                                   let address = shop["address"] as? String,
                                   let latitude = shop["latitude"] as? Double,
                                   let longitude = shop["longitude"] as? Double,
                                   let recommendation = shop["recommendation"] as? String {
                                    
                                    let place = Place(id: id, name: name, address: address, latitude: latitude, longitude: longitude, recommendation: recommendation)
                                    placesArray.append(place)
                                }
                            }
                        }
                        
                        // Store places
                        DispatchQueue.main.async {
                            self.places = placesArray
                            self.errorMessage = nil
                        }
                        
                    } catch {
                        self.errorMessage = "Error parsing JSON: \(error.localizedDescription)"
                    }
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error downloading file: \(error)")
            }
        }
    }
}
