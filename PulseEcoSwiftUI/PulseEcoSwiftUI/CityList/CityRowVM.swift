import Foundation
import SwiftUI

class CityRowVM: ObservableObject, Identifiable {
    var id: String { return cityName }
    var cityName: String
    var countryCode: String
    var countryName: String
    var message: String
    var value: Float
    var color: Color
    var unit: String
    var noReadings: Bool
    var noReadingsImage: UIImage = UIImage(named: "exclamation") ?? UIImage()

    init(cityName: String,
         countryCode: String,
         countryName: String,
         message: String,
         value: String?,
         unit: String) {
        self.cityName = cityName
        self.countryCode = countryCode
        self.countryName = countryName
        self.message = message
        if let val = value {
            if let floatValue = Float(val) {
                self.value = floatValue
                self.noReadings = false
                self.color = Color(AppColors.green)
            } else {
                self.noReadings = true
                self.value = 0
                self.color = Color(AppColors.gray)
            }
        } else {
            self.noReadings = true
            self.value = 0
            self.color = Color(AppColors.gray)
        }
        self.unit = unit
    }
}
