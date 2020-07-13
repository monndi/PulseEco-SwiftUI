import Foundation
import Combine

class DataSource: ObservableObject {
    @Published var measures: [Measure] = []
    @Published var citySensors: [SensorModel] = []
    @Published var cityOverall: CityOverallValues?
    @Published var sensorsData: [Sensor] = []
    @Published var sensorsData24h: [Sensor] = []
    @Published var cities: [CityModel] = []
    @Published var loading: Bool = true
    private var cancellableMeasures: AnyCancellable?
    private var cancellableOverallValues: AnyCancellable?
    private var cancellableSensors: AnyCancellable?
    private var cancellableSensorData: AnyCancellable?
    private var cancellableSensorData24h: AnyCancellable?
    private var cancellableCities: AnyCancellable?
    
    init() {
        getCities()
        getMeasures()
        getValuesForCity()
    }
    
    func getMeasures() {
        self.cancellableMeasures = NetworkManager().downloadMeasures().sink(receiveCompletion: { _ in }, receiveValue: { measures in
            self.measures = measures
        })
    }
    
    func getValuesForCity(cityName: String = "Skopje") {
        getOverallValues(city: cityName)
        getSensors(city: cityName)
        getCurrentDataForSensors(city: cityName)
        get24hDataForSensors(city: cityName) 
    }
    func getOverallValues(city: String) {
        self.cancellableOverallValues = NetworkManager().downloadOverallValuesForCity(cityName: city).sink(receiveCompletion: { _ in
            self.loading = false
        }, receiveValue: { values in
            self.cityOverall = values
        })
    }
    func getSensors(city: String) {
        self.cancellableSensors = NetworkManager().downloadSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.citySensors = sensors
        })
    }
    func getCurrentDataForSensors(city: String) {
        self.cancellableSensorData = NetworkManager().downloadCurrentDataForSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.sensorsData = sensors
        })
    }
    func get24hDataForSensors(city: String) {
        self.cancellableSensorData24h = NetworkManager().download24hDataForSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.sensorsData24h = sensors
        })
    }
    func getCities() {
        self.cancellableCities = NetworkManager().downloadCities().sink(receiveCompletion: { _ in }, receiveValue: { cities in
            self.cities = cities
        })
    }
    func getCurrentMeasure(selectedMeasure: String) -> Measure {
        return measures.filter{ $0.id.lowercased() == selectedMeasure.lowercased()}.first ?? Measure.empty()
    }
}
