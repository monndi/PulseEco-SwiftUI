import Foundation
import SwiftUI

class FavouriteCityRowVM: ObservableObject, Identifiable {
    var id: String { return cityName }
    var cityName: String
    var siteName: String
    var countryCode: String
    var countryName: String
    var message: String
    var value: Float
    var color: Color
    var unit: String
    var noReadings: Bool
    var noReadingsImage: UIImage = UIImage(named: "exclamation") ?? UIImage()

    init(cityName: String = "skopje",
         siteName: String = "Skopje",
         countryCode: String = "MK",
         countryName: String = "Macedonia",
         message: String = "No message",
         value: String? = "3",
         unit: String = "µq/m3") {
        self.cityName = cityName
        self.siteName = siteName
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
