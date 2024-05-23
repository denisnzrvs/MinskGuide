import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    private var placesRepo = PlacesRepository()
    private var fileContents: String?
    private var errorMessage: String?
    
    init() {
        
    }
    
    func loadData() {
        placesRepo.downloadFileFromGitHub { result in
            switch result {
                case .success(let contents):
                    self.fileContents = contents
                    self.errorMessage = nil
                    print("File contents: \(contents)")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.fileContents = nil
                    print("Error downloading file: \(error)")
            }
            
            if let errorMessage = self.errorMessage {
                print("Error: \(errorMessage)")
            }
            
            if let contents = self.fileContents {
                print("File contents:")
                print(contents)
            }
        }
    }
    
    
}
