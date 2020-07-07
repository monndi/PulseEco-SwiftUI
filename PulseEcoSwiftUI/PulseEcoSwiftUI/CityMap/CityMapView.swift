//
//  CityMapView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct CityMapView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel: CityMapVM
    @EnvironmentObject var appVM: AppVM
    @State private var showDisclaimerView = false
    @EnvironmentObject var dataSource: DataSource
    var body: some View {
        ZStack {
            MapView(viewModel: MapVM(measure: self.appVM.selectedMeasure,
                    cityName: self.appVM.cityName,
                    sensors: self.dataSource.citySensors,
                    sensorsData: self.dataSource.sensorsData,
                    measures: dataSource.measures))
                .edgesIgnoringSafeArea(.all)
//                .overlay(
//                    Rectangle()
//                        .stroke(Color(red: 236/255, green: 234/255, blue: 235/255), lineWidth: 3)
//                        .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255), radius: 3, x: 0, y: 5)
//                        .clipShape(
//                            Rectangle()
//                    )
//                        .shadow(color: Color.white, radius: 2, x: -2, y: -2)
//                        .clipShape(
//                            Rectangle()
//                    )
//            )
                .overlay(self.viewModel.backgroundColor)
                .animation(.default)
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(self.viewModel.disclaimerIconColor)
                        .frame(width: self.viewModel.disclaimerIconSize.width, height: self.viewModel.disclaimerIconSize.height)
                        .overlay(Text(self.viewModel.disclaimerIconText)
                            .foregroundColor(Color.black)
                    )
                        .padding(.bottom, 35)
                        .onTapGesture {
                            self.showDisclaimerView = true
                    }
                    
                }.padding(.trailing, 15)
            }
            AverageView(viewModel: AverageVM(measure: self.appVM.selectedMeasure, cityName: self.appVM.cityName, measuresList: self.dataSource.measures, cityValues: self.dataSource.cityOverall))
            if self.appVM.showSensorDetails {
                SensorDetailsView()
                    .edgesIgnoringSafeArea(.bottom)
            }
            if self.appVM.citySelectorClicked {
                CityListView(viewModel: CityListVM(selectedMeasure: self.appVM.selectedMeasure))
            }
        }.sheet(isPresented: self.$showDisclaimerView) {
            DisclaimerView()
                .environment(\.managedObjectContext, self.moc)
        }
    }
}


