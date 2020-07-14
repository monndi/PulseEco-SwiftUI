//
//  CityListView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import MapKit

struct FavouriteCitiesView: View {
    @ObservedObject var viewModel: FavouriteCitiesVM
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var dataSource: DataSource
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack() {
            if self.viewModel.cityList.count == 0 {
                VStack {
                    Text("").onAppear{
                    self.appVM.showSheet = true
                    self.appVM.activeSheet = .cityListView
                    }
                }
            } else {
                VStack {
                    //List {
                    ScrollView {
                        VStack {
                            ForEach(self.viewModel.getCities(), id: \.id) { city in
                                FavouriteCityRowView(viewModel: city).onTapGesture {
                                    self.appVM.citySelectorClicked = false
                                    self.appVM.cityName = city.cityName
                                    self.dataSource.loading = true
                                    self.dataSource.getValuesForCity(cityName: city.cityName)
                                    self.appVM.updateMapRegion = true
                                    self.appVM.updateMapAnnotations = true
                                }
                            }//.onDelete(perform: self.delete)
                        }
                    }
                    //}
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle").foregroundColor(Color(AppColors.purple)).onTapGesture {
                        self.appVM.showSheet = true
                        self.appVM.activeSheet = .cityListView
                    }
                    .padding([.bottom, .trailing], 20)
                    }
                }.background(Color.white)
            }
        }
        .background(Color.white)
    }
    
    func delete(at offsets: IndexSet) {
        self.viewModel.cityList.remove(atOffsets: offsets)
    }
}

//List {
//            ForEach(self.viewModel.countries, id: \.self) { gr in
//                Section(header: Text(gr)) {
//                    ForEach(self.viewModel.cityList, id: \.id) { city in
//                        CityRowView(viewModel: city).onTapGesture {
//                            self.appVM.citySelectorClicked = false
//                            self.appVM.cityName = city.cityName
//                            self.dataSource.loading = true
//                            self.dataSource.getValuesForCity(cityName: city.cityName)
//                            self.appVM.updateMapRegion = true
//                            self.appVM.updateMapAnnotations = true
//                        }.opacity(1.0)
//                    }
//                }
//            }
//        }.onAppear(perform: { UITableView.appearance().separatorColor = .clear })
