import Foundation
import Combine

class DataSource: ObservableObject {
    @Published var measures: [Measure] = []
    @Published var loading: Bool = true
    @Published var citySensors: [SensorModel] = []
    @Published var cityOverall: CityOverallValues?
    @Published var sensorsData: [Sensor] = []
    private var cancellable: AnyCancellable?
    private var cancellable1: AnyCancellable?
    private var cancellable2: AnyCancellable?
    private var cancellable3: AnyCancellable?
    
    init() {
        self.cancellable = NetworkManager().downloadMeasures().sink(receiveCompletion: { _ in }, receiveValue: { measures in
            self.measures = measures
            self.loading = false
        })
        getOverallValues(city: "Skopje")
        getSensors(city: "Skopje")
        getDataForSensors(city: "Skopje")
    }
    func getValuesForCity(cityName: String) {
        getOverallValues(city: cityName)
        getSensors(city: cityName)
        getDataForSensors(city: cityName)
    }
    func getOverallValues(city: String) {
        self.cancellable1 = NetworkManager().downloadOverallValuesForCity(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { values in
            self.cityOverall = values
            self.loading = false
        })
    }
    func getSensors(city: String) {
        self.cancellable2 = NetworkManager().downloadSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.citySensors = sensors
            self.loading = false
        })
    }
    func getDataForSensors(city: String) {
        self.cancellable3 = NetworkManager().downloadDataForSensors(cityName: city).sink(receiveCompletion: { _ in }, receiveValue: { sensors in
            self.sensorsData = sensors
            self.loading = false
        })
    }
    func getCurrentMeasure(selectedMeasure: String) -> Measure {
        return measures.filter{ $0.id.lowercased() == selectedMeasure.lowercased()}.first!
    }
}
