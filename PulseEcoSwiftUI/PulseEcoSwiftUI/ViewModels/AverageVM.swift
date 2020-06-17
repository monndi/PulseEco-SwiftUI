//
//  AverageVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

class AverageVM: ObservableObject {
    @Published var city: CityModel
    @Published var cityOverallValues: CityOverallValues
    init(cityName: String) {
        city = CityModel(cityName: "skopje", siteName: "Skopje", siteTitle: "Skopje @ CityPulse", siteURL: "https://skopje.pulse.eco", countryCode: "MK", countryName: "Macedonia", cityLocation: CityCoordinates(latitude: "42.0016", longitute: "21.4302"), cityBorderPoints :[], intialZoomLevel: 12)
        cityOverallValues = CityOverallValues(cityName: "skopje", values: Values(no2: "28", pm25: "3", o3: "36", pm10: "5", temperature: "23", humidity: "64", pressure: "967", noiseDBA: "51"))
        
    }
}
