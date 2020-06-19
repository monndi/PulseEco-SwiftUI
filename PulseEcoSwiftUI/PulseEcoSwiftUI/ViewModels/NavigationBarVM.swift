//
//  NavigationBarVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//
import Foundation

class NavigationBarVM: ObservableObject {
   
    var cityName: String
    @Published var locationClicked: Bool
    
    init() {
        cityName = "Skopje"
        locationClicked = false
    }

}

