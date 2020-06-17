//
//  NavigationBarVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//
import Foundation

class NavigationBarVM: ObservableObject {
    @Published var cityModel: CityModel
    @Published var locationClicked: Bool
    @Published var selectedItem: String
    @Published var measures: [String]
    
    init(){
        cityModel = CityModel(cityName: "skopje", siteName: "Skopje", siteTitle: "Skopje @ CityPulse", siteURL: "https://skopje.pulse.eco", countryCode: "MK", countryName: "Macedonia", cityLocation: CityCoordinates(latitude: "42.0016", longitute: "21.4302"), cityBorderPoints :[], intialZoomLevel: 12)
        locationClicked = false
        measures = ["pm10", "pm25", "noise", "tempreature", "humidity", "pressure", "NO2", "O3"]
        selectedItem = "pm10"
    }
}
