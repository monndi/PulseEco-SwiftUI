//
//  SensorVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/19/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import MapKit
import Combine

class SensorVM: NSObject, MKAnnotation {
    var title: String?
    var sensorID: String
    var value: String
    var coordinate: CLLocationCoordinate2D
    var type: SensorType
    var color: UIColor
    
    init(title: String?, sensorID: String, value: String, coordinate: CLLocationCoordinate2D, type: String, color: UIColor) {
        self.title = title ?? "Sensor"
        self.sensorID = sensorID
        self.value = value
        self.coordinate = coordinate
        self.type = SensorType(rawValue: type)!
        self.color = color
    }
    
}

