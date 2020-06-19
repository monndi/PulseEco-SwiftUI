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
    @Binding var locationClicked: Bool
    
    var body: some View {
        ZStack {
            MapView(mapVM: MapVM(), showSensorDetails: self.$cityMapVM.showSensorDetails ).edgesIgnoringSafeArea(.all)
            AverageView()
            if cityMapVM.showSensorDetails {
                SensorDetailedView()
            }
            if self.locationClicked {
                CityList(cityList: CityListVM())
            }
        }
    }
}


