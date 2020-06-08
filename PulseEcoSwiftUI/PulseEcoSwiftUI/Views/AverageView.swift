//
//  AverageView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/4/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct SubView: View {
    var scale: Bool
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack{
            VStack(alignment: .leading)
            {
                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color(UIColor.green)).frame(width: self.width, height:  20).overlay(Text("Average").font(.headline).foregroundColor(Color.black)
                )
                HStack {
                    Text("45").font(.system(size: 40)).padding(.leading, 10)
                    Text("m/s").padding(.top, 10)
                
                }
           

                Spacer()
            
            }.foregroundColor(.white)
            Spacer()
        }.padding(.leading, 8)
    }
}

struct AverageView: View {
    @State var scale: Bool = false
    @State var width: CGFloat = 120
    @State var height: CGFloat = 80
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.green)
                    .frame(width: self.width, height: self.height)
                    .overlay(SubView(scale: self.scale, width: self.width, height: self.height))
                    .padding(.top, 10)
                    .onTapGesture {
                        self.scale.toggle()
                }
                
                Spacer()
            }.padding(.leading, 20)
            
            Spacer()
            
            
        }
    }
}

struct AverageView_Previews: PreviewProvider {
    static var previews: some View {
        AverageView(scale: false)
    }
}
