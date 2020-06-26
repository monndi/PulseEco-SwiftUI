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
    var measures: [MeasureVM] = []
    @Published var selectedMeasure: String
    
    init(selectedMeasure: String, cityName: String) {
        self.selectedMeasure = selectedMeasure
        self.measures = [
            MeasureVM(title: "PM10", selectedMeasure: selectedMeasure, false),
            MeasureVM(title: "PM25", selectedMeasure: selectedMeasure, false),
            MeasureVM(title: "Noise", selectedMeasure: selectedMeasure, true),
            MeasureVM(title: "Temperature", selectedMeasure: selectedMeasure, false),
            MeasureVM(title: "Humidity", selectedMeasure: selectedMeasure, false),
            MeasureVM(title: "Preasure", selectedMeasure: selectedMeasure, false),
            MeasureVM(title: "NO2", selectedMeasure: selectedMeasure, true),
            MeasureVM(title: "O3", selectedMeasure: selectedMeasure, false)
        ]
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
    
    init(title: String, selectedMeasure: String, _ clickDisabled: Bool) {
        self.title = title
        self.selectedMeasure = selectedMeasure
        self.clickDisabled = clickDisabled
    }
}
