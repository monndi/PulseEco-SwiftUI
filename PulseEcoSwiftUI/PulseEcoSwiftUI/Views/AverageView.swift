//
//  AverageView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct SubView: View {
    var expanded: Bool
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    var city: AverageVM
    
    var body: some View {
        HStack{
            VStack(alignment: .leading)
            {
                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color(red: 0.00, green: 0.39, blue: 0.00)).frame(width: self.width, height:  25).overlay(Text("Average").font(.headline).foregroundColor(Color.white)
                )
                HStack {
                    Text(city.value).font(.system(size: 35)).padding(.leading, 10)
                    Text(city.unit).padding(.top, 10)
                    if expanded == true {
                        Text(city.message)
                    }
                }
                
                Spacer()
                if expanded == true {
                    
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(LinearGradient(
                            gradient: .init(colors: [ Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255), Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)]),
                            startPoint: .init(x: 0.5, y: 0),
                            endPoint: .init(x: 0.5, y: 0.6)
                        )).frame(width: self.width, height: 9).overlay(Slider(value: self.$width))
                    
                    
                }
                
            }.foregroundColor(.white)
            Spacer()
        }.padding(.leading, 8)
        
    }
}

struct AverageView: View {
    
    @State var expanded: Bool = false {
        didSet {
            
            width = expanded ? UIWidth - 50 : 120
            height = expanded ? 125 : 80
        }
    }
    @State var width: CGFloat = 120
    @State var height: CGFloat = 80
   
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(red: 0.00, green: 0.58, blue: 0.20))
                    .frame(width: self.width, height: self.height)
                    .overlay(SubView(expanded: self.expanded, width: self.$width, height: self.$height, city: AverageVM()))
                    .padding(.top, 10)
                    .animation(.default)
                    .onTapGesture {
                        self.expanded.toggle()
                }
                
                Spacer()
            }.padding(.leading, 20)
            
            Spacer()
            
            
        }
    }
    
  
    
    
}
