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
    var sensors = [SensorVM]()
    var measure: String
    
    init(measure: String, cityName: String, sensors: [SensorModel], sensorsData: [Sensor], measures: [Measure]) {
        let selectedMeasure = measures.filter{ $0.id.lowercased() == measure.lowercased()}.first ?? Measure.empty()
        self.cityName = cityName
        self.coordinates = cityName == "Skopje" ? CLLocationCoordinate2D(latitude: 42.0016, longitude: 21.6525) : CLLocationCoordinate2D(latitude: 41.031258, longitude: 21.334063)
        if cityName == "Cork" {
            self.coordinates = CLLocationCoordinate2D(latitude: 51.90009636861204, longitude: -8.479385375976564)
        }
        self.cityBorderPoints = [CLLocationCoordinate2D(latitude: 41.420901, longitude: 22.863232), CLLocationCoordinate2D(latitude: 41.425250, longitude: 21.4302), CLLocationCoordinate2D(latitude: 41.420049, longitude: 22.899684),CLLocationCoordinate2D(latitude: 41.407068, longitude: 22.899287),CLLocationCoordinate2D(latitude: 41.401739, longitude: 22.879608),CLLocationCoordinate2D(latitude: 41.407719, longitude: 22.863515)]
        self.intialZoomLevel = 15
        self.sensors = combine(sensors: sensors, sensorsData: sensorsData, selectedMeasure: measure).map {
            sensor in
            let coordinates = sensor.sensorModel.position.split(separator: ",")
            return SensorVM(title: sensor.sensorModel.description,
                            sensorID: sensor.sensorData.sensorID,
                            value: sensor.sensorData.value,
                            coordinate: CLLocationCoordinate2D(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!),
                            type: sensor.sensorModel.type,
                            color:  AppColors.colorFrom(string: selectedMeasure.bands.first{ band in
                                Int(sensor.sensorData.value)! >= band.from && Int(sensor.sensorData.value)! <= band.to
                                }?.legendColor ?? "gray")
            )
        }
        self.measure = measure
    }
    
}

class SensorReadings {
    var sensorModel: SensorModel
    var sensorData: Sensor
    init(sensorModel: SensorModel, sensorData: Sensor) {
        self.sensorModel = sensorModel
        self.sensorData = sensorData
    }
}

func combine(sensors: [SensorModel], sensorsData: [Sensor], selectedMeasure: String) -> [SensorReadings] {

    let sensorDataIds = sensorsData.filter { sensor in
        sensor.type.lowercased() == selectedMeasure.lowercased()
    }

    let commonSensors = sensors.filter { sensor in
        sensorDataIds.contains{
        data in
        data.sensorID == sensor.id
        }
    }
    return zip(commonSensors, sensorDataIds).map { SensorReadings(sensorModel: $0, sensorData: $1) }
}
