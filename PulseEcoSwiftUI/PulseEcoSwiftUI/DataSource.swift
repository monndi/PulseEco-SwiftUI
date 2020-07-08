import Foundation
import Combine

class DataSource: ObservableObject {
    @Published var measures: [Measure] = []
    @Published var citySensors: [SensorModel] = []
    @Published var cityOverall: CityOverallValues?
    @Published var sensorsData: [Sensor] = []
    @Published var sensorsData24h: [Sensor] = []
    @Published var loading: Bool = true
    private var cancellable: AnyCancellable?
    private var cancellable1: AnyCancellable?
    private var cancellable2: AnyCancellable?
    private var cancellable3: AnyCancellable?
    private var cancellable4: AnyCancellable?
    
    init() {
        getMeasures()
        getValuesForCity()
    }
    
    func getMeasures() {
        self.cancellable = NetworkManager().downloadMeasures().sink(receiveCompletion: { _ in }, receiveValue: { measures in
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
        self.cancellable1 = NetworkManager().downloadOverallValuesForCity(cityName: city).sink(receiveCompletion: { _ in
            self.loading = false
        }, receiveValue: { values in
            self.cityOverall = values
        })
    }
    func getSensors(city: String) {
        self.cancellable2 = NetworkManager().downloadSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.citySensors = sensors
        })
    }
    func getCurrentDataForSensors(city: String) {
        self.cancellable3 = NetworkManager().downloadCurrentDataForSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.sensorsData = sensors
        })
    }
    func get24hDataForSensors(city: String) {
        self.cancellable4 = NetworkManager().download24hDataForSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.sensorsData24h = sensors
        })
    }
    func getCurrentMeasure(selectedMeasure: String) -> Measure {
        return measures.filter{ $0.id.lowercased() == selectedMeasure.lowercased()}.first ?? Measure.empty()
    }
}
