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
            
        }.background(Color.white.shadow(color: Color.gray, radius: 5, x: 0, y: 0))
    }
}


struct MeasureButtonView: View {
    @ObservedObject var measure: MeasureVM
//
    var body: some View {
        
        VStack {
            
            Button(action:  {
                //action
                
            }) {
                    Text(measure.title).accentColor(Color.black)
                    .padding([.top, .leading, .trailing], 10)
            }
            Rectangle()
                .frame(height: 3.0, alignment: .bottom)
                .foregroundColor(measure.underlineColor)
            
            
            
        }
    }
    
}
