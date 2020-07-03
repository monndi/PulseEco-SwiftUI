import Foundation

/// Combination of measures and overall values
struct MeasureValue {
    let value: Int?
    let measure: Measure
    
    var id: String {
        get {
            return measure.id
        }
    }
}
