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
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                MeasuresScrollView(measureListVM: MeasureListVM(selectedMeasure: self.appVM.selectedMeasure, cityName: self.appVM.cityName))
                CityMapView().edgesIgnoringSafeArea([.horizontal,.bottom
                ])
            }.navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.appVM.citySelectorClicked = true
                }) {
                    Text(self.appVM.cityName)
                        .bold()
                }.accentColor(Color.black), trailing: Image(uiImage: UIImage(named: "logo-pulse")!).imageScale(.large).padding(.trailing, (UIWidth)/2.6).onTapGesture {
                    //action
                    }
            )
        }.navigationBarColor(UIColor.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
 
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}