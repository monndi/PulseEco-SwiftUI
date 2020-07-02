//
//  MeasureListVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MeasureListVM: ObservableObject {
    @Published var measures: [MeasureVM] = [
//        MeasureVM(title: "PM10", selectedMeasure: "pm10", false, icon: "icon-pm10"),
//                MeasureVM(title: "PM25", selectedMeasure: "pm10", false, icon: "icon-pm25"),
//                MeasureVM(title: "Noise", selectedMeasure: "pm10", true, icon: "icon-noise"),
//                MeasureVM(title: "Temperature", selectedMeasure: "pm10", false, icon: "icon-temperature"),
//                MeasureVM(title: "Humidity", selectedMeasure: "pm10", false, icon: "icon-humidity"),
//                MeasureVM(title: "Pressure", selectedMeasure: "pm10", false, icon: "icon-pressure"),
//                MeasureVM(title: "NO2", selectedMeasure: "pm10", true, icon: "icon-pm10"),
//                MeasureVM(title: "O3", selectedMeasure: "pm10", false, icon: "icon-pm10")
           ]
    @Published var selectedMeasure: String
    
    init(selectedMeasure: String, cityName: String, measuresList: [Measure]) {
        self.selectedMeasure = selectedMeasure
        for measure in measuresList {
            self.measures.append(MeasureVM(title: measure.buttonTitle, selectedMeasure: selectedMeasure, measure.buttonTitle.lowercased() == "o3" ? true : false, icon: measure.icon))
        }
        if cityName == "" {
            for measure in measures {
                measure.clickDisabled = false
            }
        } else {
            self.measures.sort{ (x, y) in
                y.clickDisabled == true
            }
        }
    }
}

class MeasureVM: ObservableObject {
    var id: String { return title }
    var title: String
    var selectedMeasure: String
    var underlineColor: Color { return selectedMeasure == title ? Color(AppColors.purple) : Color.white }
    var clickDisabled: Bool
    var icon: String
    init(title: String, selectedMeasure: String, _ clickDisabled: Bool, icon: String) {
        self.title = title
        self.selectedMeasure = selectedMeasure
        self.clickDisabled = clickDisabled
        self.icon = icon
    }
}
