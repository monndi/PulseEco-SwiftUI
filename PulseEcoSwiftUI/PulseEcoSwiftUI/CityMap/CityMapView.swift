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
    //  @ObservedObject var cityMapVM: CityMapVM
    @EnvironmentObject var appVM: AppVM
    @State private var showDisclaimerView = false
    @EnvironmentObject var dataSource: DataSource
    var body: some View {
        ZStack {
            MapView(mapVM: MapVM(measure: self.appVM.selectedMeasure, cityName: self.appVM.cityName))
                .overlay(
                    Rectangle()
                        .stroke(Color(red: 236/255, green: 234/255, blue: 235/255), lineWidth: 3)
                        .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255), radius: 3, x: 0, y: 5)
                        .clipShape(
                            Rectangle()
                    )
                        .shadow(color: Color.white, radius: 2, x: -2, y: -2)
                        .clipShape(
                            Rectangle()
                    )
            ).edgesIgnoringSafeArea(.all)
                .overlay(self.appVM.blurBackground == true ? Color(UIColor(red: 0.34, green: 0.38, blue: 0.44, alpha: 0.8)) : Color.clear)
                .animation(.default)
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color(UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)))
                        .frame(width: 220, height: 25)
                        .overlay(Text("Crowdsourced sensor data")
                            .foregroundColor(Color.black)
                    )
                        .padding(.bottom, 35)
                        .onTapGesture {
                            self.showDisclaimerView = true
                    }
                    
                }.padding(.trailing, 15)
            }
            AverageView(averageVM: AverageVM(measure: self.appVM.selectedMeasure, cityName: self.appVM.cityName, measuresList: self.dataSource.measures))
            if self.appVM.showSensorDetails {
                SensorDetailedView().edgesIgnoringSafeArea(.bottom)
            }
            if self.appVM.citySelectorClicked {
                CityList(cityList: CityListVM(selectedMeasure: self.appVM.selectedMeasure))
            }
        }.sheet(isPresented: self.$showDisclaimerView) {
            Disclaimer().environment(\.managedObjectContext, self.moc)
        }
    }
}


