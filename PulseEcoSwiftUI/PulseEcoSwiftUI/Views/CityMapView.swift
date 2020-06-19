//
//  CityMapView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct CityMapView: View {
    @ObservedObject var cityMapVM: CityMapVM
    @ObservedObject var navVM: NavigationBarVM
    
    var body: some View {
        ZStack {
            MapView(mapVM: MapVM(), showSensorDetails: self.$cityMapVM.showSensorDetails, sensorCliked: self.$cityMapVM.sensorClicked).edgesIgnoringSafeArea(.all)
            AverageView()
            if cityMapVM.showSensorDetails == true { SensorDetailedView() }
            if self.navVM.locationClicked == true {
                CityList(cityList: CityListVM())
            }
            
        }
    }
}


