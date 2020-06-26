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
    
    var cityList: CityListVM
    @EnvironmentObject var appVM: AppVM
    let countries = [
        "Macedonia",
        "Switzerland"
    ]
    var body: some View {
        List {
            ForEach(countries, id: \.self) { gr in
                Section(header: Text(gr)) {
                    ForEach(self.cityList.cityList, id: \.id) { city in
                        CityRow(city: city).onTapGesture {
                            self.appVM.citySelectorClicked = false
                            self.appVM.cityName = city.cityName
                            self.appVM.updateMap = true
                        }.opacity(1.0)
                    }
                }
            }
        }.onAppear(perform: { UITableView.appearance().separatorColor = .clear })
        
    }
}







//        List(cityList.cityList, id: \.id) { city in
//             Section(header: Text("Macedonia")) {
//                CityRow(city: city).onTapGesture {
//                    self.appVM.locationClicked = false
//                    self.appVM.cityName = city.cityName
//                }.opacity(1.0)
//            }
//        }.listStyle(.grouped)
//.onAppear(perform: { UITableView.appearance().separatorColor = .clear })

