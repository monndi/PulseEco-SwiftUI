//
//  CityRowView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import CoreLocation

struct FavouriteCityRowView: View {
    var viewModel: FavouriteCityRowVM
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.siteName)
                        .font(.headline)
                    Text(self.viewModel.countryName)
                        .padding(.top, 2)
                    Text(self.viewModel.message)
                        .padding(.top, 2)
                }
                Spacer()
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(self.viewModel.color)
                    .frame(width: 80, height: 80)
                    .overlay(VStack {
                        if self.viewModel.noReadings == false {
                            Text("\(Int(self.viewModel.value))")
                                .font(.system(size: 25))
                            Text(self.viewModel.unit)
                        } else {
                            Image(uiImage: self.viewModel.noReadingsImage)
                                .resizable()
                                .scaledToFit()
                                .padding(20)
                        }
                    })
                    .foregroundColor(Color.white)
                    .padding(10)
            }.padding([.leading, .top, .trailing], 10)
            .frame(height: 90)
            Divider()
        }
    }
}
