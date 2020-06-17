//
//  CityListView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import MapKit

struct CityList: View {
    @Binding var locationClicked: Bool
    @Binding var cityModel: CityModel
    @ObservedObject var cityList: CityListVM
  
    var body: some View {
        

        List(cityList.cityList, id: \.id) { city in
            CityRow(city: city).onTapGesture {
                                self.locationClicked = false
                                self.cityModel = city

                            }.opacity(1.0)
            
        }.onAppear(perform: { UITableView.appearance().separatorColor = .clear })
       
    }
}

