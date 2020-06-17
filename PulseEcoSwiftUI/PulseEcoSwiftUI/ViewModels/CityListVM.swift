//
//  CityListVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

class CityListVM: ObservableObject {
    
    @Published var cityList: [CityModel]
    
    init() {
        cityList = [CityModel(cityName: "skopje", siteName: "Skopje", siteTitle: "Skopje @ CityPulse", siteURL: "https://skopje.pulse.eco", countryCode: "MK", countryName: "Macedonia", cityLocation: CityCoordinates(latitude: "42.0016", longitute: "21.4302"), cityBorderPoints :[], intialZoomLevel: 12), CityModel(cityName: "bitola", siteName: "Bitola", siteTitle: "Bitola  CityPulse", siteURL: "https://bitola.pulse.eco", countryCode: "MK", countryName: "Macedonia", cityLocation: CityCoordinates(latitude: "52.0016", longitute: "21.4302"), cityBorderPoints :[], intialZoomLevel: 12)]
    }
}
