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
    
    var measures: [MeasureVM]
    @Published var selectedMeasure: String
    init(){
        measures = [MeasureVM(title: "PM10", isSelected: true), MeasureVM(title: "PM25", isSelected: false), MeasureVM(title: "Noise", isSelected: false), MeasureVM(title: "Temperature", isSelected: false), MeasureVM(title: "Humidity", isSelected: false), MeasureVM(title: "Preasure", isSelected: false), MeasureVM(title: "NO2", isSelected: false), MeasureVM(title: "O3", isSelected: false)]
        selectedMeasure = "PM10"
    }
}

class MeasureVM {
    var id: String {return title}
    var title: String
    var isSelectd: Bool
    var underlineColor: Color { return isSelectd ? Color(AppColors.purple) : Color.white }
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelectd = isSelected
    }
    
}
