//
//  MainView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var navigationBarVM = NavigationBarVM()
    var body: some View {
        NavigationView {
            VStack {
                MeasuresScrollView(measures: self.navigationBarVM)
                CityMapView(cityMapVM: CityMapVM(city: navigationBarVM.cityModel), navVM: self.navigationBarVM).edgesIgnoringSafeArea(.all)
                
            
            } .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.navigationBarVM.locationClicked = true
                    
                }) {
                    
                    Text(self.navigationBarVM.locationClicked ? "" : self.navigationBarVM.cityModel.cityName)
                        .bold()
                    
                    
                }.accentColor(Color.black), trailing: Image(uiImage: UIImage(named: "logo-pulse")!).imageScale(.large).padding(.trailing, (UIWidth)/2.6).onTapGesture {
                    //action
                    }
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
