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
                MeasuresScrollView(measureListVM: MeasureListVM())
                CityMapView(cityMapVM: CityMapVM(), locationClicked: self.$navigationBarVM.locationClicked).edgesIgnoringSafeArea(.all)
            } .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.navigationBarVM.locationClicked = true
                    
                }) {
                    Text(self.navigationBarVM.cityName)
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
