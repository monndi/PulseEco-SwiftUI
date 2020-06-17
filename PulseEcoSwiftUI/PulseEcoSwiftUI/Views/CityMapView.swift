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
            MapView(mapVM: MapVM(cityModel: cityMapVM.city), showDetails: self.$cityMapVM.showDetails, sensorCliked: self.$cityMapVM.sensorClicked).edgesIgnoringSafeArea(.all)
            AverageView(averageVM: AverageVM(cityName: cityMapVM.city.cityName))
            if cityMapVM.showDetails == true { SensorDetailedView() }
            if self.navVM.locationClicked == true {
                CityList(locationClicked: self.$navVM.locationClicked, cityModel: self.$navVM.cityModel, cityList: CityListVM())
            }
            
        }
    }
}


