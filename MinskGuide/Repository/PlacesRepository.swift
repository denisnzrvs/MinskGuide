import Foundation

class PlacesRepository {
    
    func downloadFileFromGitHub(completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/denisnzrvs/MinskGuideFiles/master/places.json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // Convert data to string
            if let fileContents = String(data: data, encoding: .utf8) {
                completion(.success(fileContents))
            } else {
                let error = NSError(domain: "DataError", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
