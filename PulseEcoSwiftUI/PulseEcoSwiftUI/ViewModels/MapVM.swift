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
    
    var cityName: String
    var coordinates: CLLocationCoordinate2D
    var intialZoomLevel: Int
    var cityBorderPoints: [CLLocationCoordinate2D]
    var sensors = [SensorModel]()
    
    init() {
        
        self.cityName = "Skopje"
        self.coordinates = CLLocationCoordinate2D(latitude: 41.9875, longitude: 21.6525)
        self.cityBorderPoints = [CLLocationCoordinate2D(latitude: 41.420901, longitude: 22.863232), CLLocationCoordinate2D(latitude: 41.425250, longitude: 22.880324), CLLocationCoordinate2D(latitude: 41.420049, longitude: 22.899684),CLLocationCoordinate2D(latitude: 41.407068, longitude: 22.899287),CLLocationCoordinate2D(latitude: 41.401739, longitude: 22.879608),CLLocationCoordinate2D(latitude: 41.407719, longitude: 22.863515)]
        self.intialZoomLevel = 15
        self.sensors = [SensorModel(sensorID: "1001", position: "41.9875,21.6525", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE"), SensorModel(sensorID: "1002", position: "41.995828195848325,21.484215259552002", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE"), SensorModel(sensorID: "1003", position: "42.027618975073544,21.38741970062256", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE"), SensorModel(sensorID: "1004", position: "41.98370716725851,21.467853784561157", comments: "MOEPP sensor at Miladinovci", type: "0", description: "MOEPP Miladinovci", status: "ACTIVE")]
        
    }
    
}

