//
//  CityRowView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//


import SwiftUI
import CoreLocation



struct CityRow: View {
    
    var city: CityModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text(city.siteName).font(.headline)
                    Text(city.countryName).padding(.top, 2)
                    Text(city.siteTitle).padding(.top, 2)
                }
                Spacer()
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(UIColor.systemGreen))
                    .frame(width: 80, height: 80)
                    .overlay(Text("2"))
                    .foregroundColor(Color.white)
                    .padding(10)
                
            }
            .padding([.leading, .top, .trailing], 10)
            .frame(height: 90)
            Divider()

        }
        
    }
}
