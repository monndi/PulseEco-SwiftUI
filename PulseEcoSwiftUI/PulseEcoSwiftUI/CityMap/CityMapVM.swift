//
//  CityMapVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

class CityMapVM: ObservableObject {
    
    @Published var showSensorDetails: Bool
    @Published var citySelectorClicked: Bool
    
    init(citySelectorClicked: Bool, showSensorDetails: Bool) {
        self.citySelectorClicked = citySelectorClicked
        self.showSensorDetails = showSensorDetails
    }
}
