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
    @Published var measures: [MeasureVM] = []
    @Published var selectedMeasure: String
    
    init(selectedMeasure: String, cityName: String, measuresList: [Measure], cityValues: CityOverallValues?) {
        self.selectedMeasure = selectedMeasure
        for measure in measuresList {
            let measureVM = MeasureVM(id: measure.id, title: measure.buttonTitle, selectedMeasure: selectedMeasure, icon: measure.icon)
            self.measures.append(measureVM)
            if cityValues?.values[measure.id.lowercased()] == nil {
                measureVM.clickDisabled = true
            }
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
    var id: String
    var title: String
    var selectedMeasure: String
    var underlineColor: Color { return selectedMeasure == id ? Color(AppColors.purple) : Color.clear }
    var clickDisabled: Bool = false
    var icon: String
    init(id: String, title: String, selectedMeasure: String, icon: String) {
        self.id = id
        self.title = title
        self.selectedMeasure = selectedMeasure
        self.icon = icon
    }
}
