//
//  MainView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var dataSource: DataSource
    
    var body: some View {
        LoadingView(isShowing: .constant(self.dataSource.loading)) {
            NavigationView {
                VStack(alignment: .center, spacing: 0) {
                    MeasureListView(viewModel: MeasureListVM(selectedMeasure: self.appVM.selectedMeasure, cityName: self.appVM.cityName, measuresList: self.dataSource.measures, cityValues: self.dataSource.cityOverall))
                    CityMapView(viewModel: CityMapVM(blurBackground: self.appVM.blurBackground))
                        .edgesIgnoringSafeArea([.horizontal,.bottom
                    ])
                }.navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        self.appVM.citySelectorClicked = true
                    }) {
                        Text(self.appVM.cityName)
                            .bold()
                    }.accentColor(Color.black), trailing: Image(uiImage: UIImage(named: "logo-pulse") ?? UIImage())
                        .imageScale(.large)
                        .padding(.trailing, (UIWidth)/2.6)
                        .onTapGesture {
                            //action
                        }
                    )
                }.navigationBarColor(UIColor.white)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}


