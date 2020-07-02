import Foundation
import SwiftUI
class AppVM: ObservableObject {
   
    @Published var selectedMeasure: String = "PM10"
    @Published var citySelectorClicked: Bool = false {
        didSet {
           cityName = citySelectorClicked ? "" : cityName
        }
    }
    @Published var cityName: String = "Skopje"
    @Published var showSensorDetails: Bool = false
    @Published var sensorSelected: SensorVM?
    @Published var updateMap: Bool = true
    @Published var blurBackground: Bool = false
}
