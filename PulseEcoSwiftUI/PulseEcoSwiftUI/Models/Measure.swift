//
//  Measure.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/11/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct Measure: Codable, Identifiable {
    
    
    let id, buttonTitle, title, icon: String
    let welcomeDescription: String
    let showMin, showMax, legendMin, legendMax: Int
    let unit: String
    let showMessages: Bool
    let bands: [Band]

    enum CodingKeys: String, CodingKey {
        case id, buttonTitle, title, icon
        case welcomeDescription = "description"
        case showMin, showMax, legendMin, legendMax, unit, showMessages, bands
    }
}

// MARK: - Band
struct Band: Codable {
    let from, to, legendPoint: Int
    let legendColor, markerColor, shortGrade, grade: String
    let suggestion: String
}

typealias Measures = [Measure]