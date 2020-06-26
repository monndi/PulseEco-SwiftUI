//
//  MeasuresScrollView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct MeasuresScrollView: View {
    @ObservedObject var measureListVM: MeasureListVM
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(measureListVM.measures, id: \.id) { item in
                    VStack {
                        MeasureButtonView(measure: item)
                    }
                }
            }
        }.minimumScaleFactor(0.90)
            .background(Color(UIColor.white).shadow(color: Color(UIColor(red: 0.87, green: 0.89, blue: 0.92, alpha: 1.00)), radius: 0.8, x: 0, y: 0))
    }
}

struct MeasureButtonView: View {
    @ObservedObject var measure: MeasureVM
    @EnvironmentObject var appVM: AppVM
    
    var body: some View {
        VStack {
            Button(action:  {
                self.appVM.selectedMeasure = self.measure.title
            }) {
                Text(self.measure.title).accentColor(measure.clickDisabled ? Color.gray : Color.black)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.horizontal, 8)
                    .scaledToFit()
            }.disabled(measure.clickDisabled).padding(.top, 10)
            Rectangle()
                .frame(height: 3.0)
                .foregroundColor(measure.underlineColor)
        }
    }
}

