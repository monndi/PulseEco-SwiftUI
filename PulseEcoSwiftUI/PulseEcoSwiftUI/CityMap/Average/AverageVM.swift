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
    var value: Float
    var unit: String
    var message: String
    var measure: String
    var cityName: String
    var clickDisabled: Bool
    var bands: [BandVM] = []
    var min: Int
    var max: Int
    var currBand: BandVM?
    var measureBandsWidth: Double
    var selectedMeasure: Measure = Measure.empty()
    
    init(measure: String, cityName: String, measuresList: [Measure], cityValues: CityOverallValues?) {
        if let averageValue = cityValues?.values[measure.lowercased()] {
            if let floatValue = Float(averageValue) {
                self.value = floatValue
                self.clickDisabled = false
            } else {
                self.clickDisabled = true
                self.value = 0
            }
        } else {
            self.clickDisabled = true
            self.value = 0
        }
        self.measureBandsWidth = 100
        self.message = "No message!"
        self.measure = measure
        self.unit = "µq/m3"
        self.cityName = cityName
        self.min = 0
        self.max = 200
        self.appendBands(measuresList: measuresList)
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
        let selectedMeasure = measuresList.filter{ $0.id.lowercased() == measure.lowercased()}.first ?? Measure.empty()
        self.selectedMeasure = selectedMeasure
        self.min = selectedMeasure.legendMin
        self.max = selectedMeasure.legendMax
        self.measureBandsWidth = selectedMeasureRange(bands: selectedMeasure.bands)
        self.setBandsRange(bands: selectedMeasure.bands)
        self.message = self.currBand?.grade ?? "No message!"
        self.unit = selectedMeasure.unit
    }
    func selectedMeasureRange(bands: [Band]) -> Double {
        var rangeWidth = 0.0
        for indx in 0...bands.count-1 {
            let band = bands[indx]
            var nextValue = indx >= bands.count - 1 ? abs(Double(abs(self.max) - band.from)) : Double(abs(band.to) - band.from)
            if indx == 0 {
                nextValue = Double(abs(band.to) - self.min)
            }
            var bandRangeWidth = nextValue
            
            if isHugeValue() && indx == bands.count - 1 {
               // bandRangeWidth = nextValue * (Double(self.value) / Double(self.max))
                bandRangeWidth = nextValue + (Double(self.value) - Double(self.max))
            }
            if isLowValue() && indx == 0 {
                bandRangeWidth = nextValue + abs(Double(self.value) + Double(self.min))
            }
            rangeWidth += bandRangeWidth
        }
        return rangeWidth
    }
    
    func setBandsRange(bands: [Band]) {
        for indx in 0...bands.count-1 {
            let band = bands[indx]
            var nextValue = indx >= bands.count - 1 ? abs(Double(abs(self.max) - band.from)) : Double(abs(band.to) - band.from)
            if indx == 0 {
                nextValue = Double(abs(band.to) - self.min)
            }
            var bandRangeWidth = nextValue
        
            if isHugeValue() && indx == bands.count-1 {
               // bandRangeWidth = nextValue * (Double(self.value) / Double(self.max))
                bandRangeWidth = nextValue + (Double(self.value) - Double(self.max))
            }
            if isLowValue() && indx == 0 {
                bandRangeWidth = nextValue + abs(Double(self.value) + Double(self.min))
            }
            let width = (bandRangeWidth * 100 ) / self.measureBandsWidth
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
        return Int(self.value) >= self.max
    }
    
    func isLowValue() -> Bool {
        return Int(self.value) <= self.min
    }
    
    func valueInBand(from: Int, to: Int) -> Bool {
        return Int(value) >= from && Int(value) <= to
    }
    func sliderValue() -> Double {
        if isHugeValue() {
            return 97
        } else if isLowValue() {
            return 0
        } else {
            if self.selectedMeasure.id != "temperature" {
                 return (abs(Double(self.value)) - Double(self.min)) * 100 / self.measureBandsWidth
            } else {
                return (abs(Double(self.value)) - Double(self.min - 5)) * 100 / self.measureBandsWidth
            }
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

