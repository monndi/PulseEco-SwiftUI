//
//  MapVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import MapKit
import Combine

class MapVM: ObservableObject {
    
    @Published var cityModel: CityModel
    @Published var sensors = [SensorModel]()
 
   
    
    init(cityModel: CityModel) {
         
        self.cityModel = cityModel
        self.sensors = [SensorModel(sensorID: "1001", position: "41.9875,21.6525", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE"), SensorModel(sensorID: "1002", position: "41.995828195848325,21.484215259552002", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE"), SensorModel(sensorID: "1003", position: "42.027618975073544,21.38741970062256", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE"), SensorModel(sensorID: "1004", position: "41.98370716725851,21.467853784561157", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE")]
        
    }
      
}

