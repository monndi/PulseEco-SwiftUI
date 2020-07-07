//
//  Measure.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/11/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - WelcomeElement
struct Measure: Codable, Identifiable {
    
    
    let id, buttonTitle, title, icon: String
    let description: String
    let showMin, showMax, legendMin, legendMax: Int
    let unit: String
    let showMessages: Bool
    let bands: [Band]

    enum CodingKeys: String, CodingKey {
        case id, buttonTitle, title, icon
        case description
        case showMin, showMax, legendMin, legendMax, unit, showMessages, bands
    }
    
    
    static func empty() -> Measure {
        return Measure(id: "--",
                       buttonTitle: "--",
                       title: "--",
                       icon: "wifi",
                       description: "--",
                       showMin: 0,
                       showMax: NSIntegerMax,
                       legendMin: 0,
                       legendMax: 100,
                       unit: "--",
                       showMessages: false,
                       bands: [Band.empty()])
    }
}

// MARK: - Band
struct Band: Codable {
    let from, to, legendPoint: Int
    let legendColor, markerColor, shortGrade, grade: String
    let suggestion: String
    
    static func == (lhs: Band, rhs: Band) -> Bool {
          return lhs.legendPoint == rhs.legendPoint
      }
    static func empty() -> Band {
        return Band(from: 0,
                       to: NSIntegerMax,
                       legendPoint: 0,
                       legendColor: "gray",
                       markerColor: "gray",
                       shortGrade: "--",
                       grade: "--",
                       suggestion: "--")
    }
}


