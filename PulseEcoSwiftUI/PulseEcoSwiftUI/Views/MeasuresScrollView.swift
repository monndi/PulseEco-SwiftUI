//
//  MeasuresScrollView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct MeasuresScrollView: View {
    
    @ObservedObject var measures: NavigationBarVM
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(measures.measures, id: \.self) { item in
                    
                    VStack {
                        MeasureButtonView(title: item, selectedItem: self.$measures.selectedItem)
                    }
                    
                    
                }
            }
            
        }.background(Color.white.shadow(color: Color.gray, radius: 5, x: 0, y: 0))
    }
}

struct MeasureButtonView: View {
    var title: String
    @Binding var selectedItem: String
    
    var isSelected: Bool {
        selectedItem == title
    }
    
    var body: some View {
     
            VStack {
                
                Button(action: { self.selectedItem = self.title }) {
                    Text(self.title).accentColor(Color.black)
                        .padding([.top, .leading, .trailing], 10)
                    
                }
                Rectangle()
                    .frame(height: 3.0, alignment: .bottom)
                    .foregroundColor(self.isSelected ? Color(AppColors.purple) : Color.white)
                
                
                
            }
    }
    
}
