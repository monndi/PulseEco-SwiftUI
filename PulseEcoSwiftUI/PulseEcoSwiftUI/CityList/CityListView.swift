//
//  CityListView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import MapKit

struct CityListView: View {
    
    var viewModel: CityListVM
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var dataSource: DataSource
    
    var body: some View {
        List {
            ForEach(self.viewModel.countries, id: \.self) { gr in
                Section(header: Text(gr)) {
                    ForEach(self.viewModel.cityList, id: \.id) { city in
                        CityRowView(viewModel: city).onTapGesture {
                            self.appVM.citySelectorClicked = false
                            self.appVM.cityName = city.cityName
                            self.dataSource.loading = true
                            self.dataSource.getValuesForCity(cityName: city.cityName)
                            self.appVM.updateMapRegion = true
                            self.appVM.updateMapAnnotations = true
                        }.opacity(1.0)
                    }
                }
            }
        }.onAppear(perform: { UITableView.appearance().separatorColor = .clear })
    }
}
