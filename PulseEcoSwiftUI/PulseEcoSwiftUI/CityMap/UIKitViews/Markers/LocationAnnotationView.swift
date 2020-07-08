//
//  SensorAnnotationView.swift
//  PulseEcoSwiftUI
//
//  Created by Marko Nikolov on 7/7/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

//import SwiftUI
import MapKit
import Foundation
import SwiftUI

class LocationAnnotationView: MKAnnotationView {

    var pin: SensorVM?


    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.pin = annotation as? SensorVM

        
        frame = CGRect(x: 0, y: 0, width: 35, height: 48)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupUI() {
        let markerIconView = UINib(nibName: "MarkerView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MarkerView
        markerIconView.setup(withValue: Double(pin!.value)!, color: pin!.color)
        addSubview(markerIconView)
        markerIconView.frame = bounds
        
    }
}
