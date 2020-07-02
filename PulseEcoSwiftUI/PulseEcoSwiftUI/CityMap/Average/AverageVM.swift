//
//  AverageVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class AverageVM: ObservableObject {
    var value: String?
    var unit: String
    var message: String
    var measure: String
    var cityName: String
    var clickDisabled: Bool { return value == nil }
    var bands: [BandVM] = []
    var min: Int
    var max: Int
    var currBand: BandVM?
    
    init(measure: String, cityName: String, measuresList: [Measure]) {
        switch measure {
        case "PM10":
            self.value = "5"
        case "PM25":
            self.value = "30"
        case "Temperature":
            self.value = "-20"
        case "Noise":
            self.value = "40"
        case "NO2":
            self.value = "-3"
        default:
            self.value = nil
        }
       // self.value = measure == "PM10" ? "5" : nil
        self.message = "No message!"
        self.measure = measure
        self.unit = measure == "PM10" ? "µq/m3" : "C"
        self.cityName = cityName
        if self.cityName == "Bitola" {
            self.value = "250"
        }
        self.min = 0
        self.max = 200
        if measuresList.count != 0 {
            self.appendBands(measuresList: measuresList)
        }
    }
    func colorForValue() -> UIColor {
        guard let band = currBand else {
            return UIColor.gray
        }
        return band.legendColor
    }
    
    func shortGrade(forValue value: Int?) -> String {
        return self.band(forValue: value)?.shortGrade ?? "--"
    }
    
    private func band(forValue value: Int?) -> BandVM? {
        return bands.first { $0.valueInBand(value: value) }
    }
    
    func appendBands(measuresList: [Measure]) {
        let selectedMeasure = measuresList.filter{ $0.buttonTitle.lowercased() == measure.lowercased()}.first!
        self.min = selectedMeasure.legendMin
        self.max = selectedMeasure.legendMax
        self.setBandsRange(bands: selectedMeasure.bands)
        self.message = self.currBand?.grade ?? "No message!"
        self.unit = selectedMeasure.unit
    }
    func selectedMeasureRange(bands: [Band]) -> Double {
        var sum = 0.0
        for indx in 0...bands.count-1 {
            let band = bands[indx]
            var nextValue = indx >= bands.count - 1 ? abs(Double(abs(self.max) - band.from)) : Double(abs(band.to) - band.from)
            if indx == 0 {
                nextValue = Double(abs(band.to) - self.min)
            }
            var bandRangeWidth = nextValue
            if self.valueInBand(from: band.from, to: band.to > self.max ? self.max : band.to) {
                bandRangeWidth *= 2
            }
            if isHugeValue() && indx == bands.count-1 {
                bandRangeWidth = nextValue * (Double(self.value ?? "1")! - Double(self.max))
            }
            if isLowValue() && indx == 0 {
                bandRangeWidth = nextValue * abs(Double(self.value ?? "1")! + Double(self.min))
            }
            sum += bandRangeWidth
        }
        return sum
    }
    
    func setBandsRange(bands: [Band]) {
        for indx in 0...bands.count-1 {
            let band = bands[indx]
            var nextValue = indx >= bands.count - 1 ? abs(Double(abs(self.max) - band.from)) : Double(abs(band.to) - band.from)
            if indx == 0 {
                nextValue = Double(abs(band.to) - self.min)
            }
            var bandRangeWidth = nextValue
            if self.valueInBand(from: band.from, to: band.to > self.max ? self.max : band.to) {
                bandRangeWidth = 2 * nextValue
            }
            if isHugeValue() && indx == bands.count-1 {
                              bandRangeWidth = nextValue * (Double(self.value ?? "1")! - Double(self.max))
            }
            if isLowValue() && indx == 0 {
                              bandRangeWidth = nextValue * abs(Double(self.value ?? "1")! + Double(self.min))
            }
            let width = (bandRangeWidth * 100 ) / selectedMeasureRange(bands: bands)
            let bandVM = BandVM(from: band.from, to: band.to, legendPoint: band.legendPoint, legendColor: AppColors.colorFrom(string: band.legendColor), markerColor: AppColors.colorFrom(string: band.markerColor), shortGrade: band.shortGrade, grade: band.grade, suggestion: band.suggestion, width: width)
            self.bands.append(bandVM)
            if self.valueInBand(from: band.from, to: band.to) {
                currBand = bandVM
            }
        }
        if isHugeValue() {
             self.currBand = self.bands[self.bands.count - 1]
        } else if isLowValue() {
            self.currBand = self.bands[0]
        }
       
    }
    
    func isHugeValue() -> Bool {
        return Int(self.value ?? "1")! > self.max
    }
    
    func isLowValue() -> Bool {
        return Int(self.value ?? "1")! < self.min
    }
    
    func valueInBand(from: Int, to: Int) -> Bool {
        guard let value = Int(self.value ?? "1")  else {
            return false
        }
        return value >= from && value <= to
    }
    func sliderValue() -> Float {
        if isHugeValue() {
            return Float(self.max)
        } else if isLowValue() {
            return Float(self.min)
        } else {
            return Float(self.value ?? "1")!
        }
    }
    func sliderRange() -> ClosedRange<Float> {
        if isHugeValue() {
            return Float(self.currBand?.from ?? 1)...Float(self.max + 10)
        } else if isLowValue() {
            return Float(self.min)...Float(self.currBand?.to ?? 1)
        } else {
            return Float(self.currBand?.from ?? 1)...Float(self.currBand?.to ?? 1)
        }
    }
}

class BandVM: Identifiable {
    let from: Int
    let to: Int
    let legendPoint: Int
    let legendColor: UIColor
    let markerColor: UIColor
    let shortGrade: String
    let grade: String
    let suggestion: String
    var width: Double
    init(from: Int, to: Int, legendPoint: Int, legendColor: UIColor, markerColor: UIColor, shortGrade: String, grade: String, suggestion: String, width: Double) {
        self.from = from
        self.to = to
        self.legendPoint = legendPoint
        self.legendColor = legendColor
        self.markerColor = markerColor
        self.shortGrade = shortGrade
        self.grade = grade
        self.suggestion = suggestion
        self.width = width
    }
    
    func valueInBand(value: Int?) -> Bool {
        guard let value = value else {
            return false
        }
        return value >= from && value <= to
    }
}

