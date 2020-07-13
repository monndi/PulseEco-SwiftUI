
import Foundation

class UserSettings: ObservableObject {
    @Published var favouriteCities: Set<CityModel> {
        didSet {
           save()
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "FavouriteCities") {
            if let decoded = try? JSONDecoder().decode(Set<CityModel>.self, from: data) {
                self.favouriteCities = decoded
                return
            }
        }
        self.favouriteCities = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favouriteCities) {
            UserDefaults.standard.set(encoded, forKey: "FavouriteCities")
        }
    }
}
