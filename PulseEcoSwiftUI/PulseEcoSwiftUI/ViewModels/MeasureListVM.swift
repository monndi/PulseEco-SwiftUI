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
    init(){
        selectedMeasure = "PM10"
        self.measures = [MeasureVM(title: "PM10", selectedMeasure: selectedMeasure), MeasureVM(title: "PM25", selectedMeasure: selectedMeasure), MeasureVM(title: "Noise", selectedMeasure: selectedMeasure), MeasureVM(title: "Temperature", selectedMeasure: selectedMeasure), MeasureVM(title: "Humidity", selectedMeasure: selectedMeasure), MeasureVM(title: "Preasure", selectedMeasure: selectedMeasure), MeasureVM(title: "NO2", selectedMeasure: selectedMeasure), MeasureVM(title: "O3", selectedMeasure: selectedMeasure)]
        
    }
}

class MeasureVM: ObservableObject {
    var id: String {return title}
    var title: String
    var selectedMeasure: String
    var underlineColor: Color { return selectedMeasure == title ? Color(AppColors.purple) : Color.white }
    
    init(title: String, selectedMeasure: String) {
        self.title = title
        self.selectedMeasure = selectedMeasure
    }
    
}
