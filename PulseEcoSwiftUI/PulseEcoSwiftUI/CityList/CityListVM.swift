
import Foundation

class CityListVM: ObservableObject {
    @Published var cities: [CityRowVM] = []
    @Published var cityModel: [CityModel] = []
    @Published var searchText : String = ""
    var text: String {
        return searchText == "" ? "Suggested" : "Results"
    }
    @Published var countries = Set<String>()
    
    init(cities: [CityModel]) {
        self.cityModel = cities
        for city in cities {
            self.cities.append(CityRowVM(cityName: city.cityName, siteName: city.siteName, countryName: city.countryName, countryCode: city.countryCode))
            self.countries.insert(city.countryName)
            }
    }
}
