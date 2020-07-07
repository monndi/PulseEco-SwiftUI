//
//  City1.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/10/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation


// Mark - Results



// MARK: - CityModel
struct CityModel: Codable, Identifiable {
    var id: String { return cityName }
    let cityName, siteName, siteTitle: String
    let siteURL: String
    let countryCode, countryName: String
    let cityLocation: CityCoordinates
    let cityBorderPoints: [CityCoordinates]
    let intialZoomLevel: Int

    enum CodingKeys: String, CodingKey {
        case cityName, siteName, siteTitle
        case siteURL = "siteUrl"
        case countryCode, countryName, cityLocation, cityBorderPoints, intialZoomLevel
    }
}

// MARK: - CityCoordinates
struct CityCoordinates: Codable {
    let latitude, longitute: String
}



