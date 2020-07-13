
import Foundation

class CityListVM: ObservableObject {
    @Published var cities: [CityRowVM] = []
    @Published var cityModel: [CityModel] = []
    init(cities: [CityModel]) {
        self.cityModel = cities
        for city in cities {
            self.cities.append(CityRowVM(cityName: city.cityName, siteName: city.siteName, countryName: city.countryName, countryCode: city.countryCode))
        }
    }
}
