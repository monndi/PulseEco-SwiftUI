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
    var geometry: GeometryProxy
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 3)
            {
                //RoundedRectangle(cornerRadius: 5, style: .continuous)
                RoundedCorners(tl: 5, tr: 5, bl: 0, br: 0).fill(Color(red: 0.00, green: 0.39, blue: 0.00)).frame(width: self.width, height:  25).overlay( Text("Average").foregroundColor(Color.white).padding(.leading, 10), alignment: .leading
                )
                HStack(alignment: .center, spacing: 0) {
                    Text(self.city.value!).font(.system(size: 35)).padding(.leading, 10)
                    Text(self.city.unit).padding(.top, 15).padding(.leading, 3)
                    if self.expanded == true {
                        GeometryReader { geo in
                            Text(self.city.message).fixedSize(horizontal: false, vertical: true).font(.system(size: geo.size.height / 4.5)).padding(.leading, 10)
                                //.onAppear{
//                             self.width = self.geometry.frame(in: .local).midX * 1.8
//                                        self.height = 120//geo.frame(in: .global).midY * 0.65
//
//                            }
                            //                                .frame(width: geo.frame(in: .global).midX, height: geo.frame(in: .global).midY)
                          
//                            .onAppear {
//                                    self.width = self.geometry.frame(in: .local).midX * 1.8
//                                  self.height = 120//geo.frame(in: .global).midY * 0.65
//                            }.onDisappear{
//                                self.width =  self.geometry.frame(in: .local).midX * 0.7
//                                self.height = 65//self.geometry.frame(in: .local).midY * 0.25
//                            }.animation(.default)
                        }
                    }
                }
                Spacer()
            }.foregroundColor(.white)
            Spacer()
        }.padding(.leading, 8)
    }
}

struct AverageView: View {
    
    @State var expanded: Bool = false
//            {
//            didSet {
//
//                width = expanded ? UIWidth - 40 : 125
//                height = expanded ? 120 : 70
//            }
//        }
    @State var width: CGFloat = 125
    @State var height: CGFloat = 70
    var averageVM: AverageVM
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    if self.averageVM.clickDisabled == false  {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: 0.00, green: 0.58, blue: 0.20))
                            .frame(width: self.width, height: self.height)
                            .overlay(SubView(expanded: self.expanded, width: self.$width, height: self.$height, city: self.averageVM, geometry: geo))
                            .padding(.top, 20)
                            .animation(.default)
                            .onTapGesture {
                                if let _ = self.averageVM.value {
                                    self.expanded.toggle()
                                
                                    self.width = self.expanded ? geo.frame(in: .local).midX * 1.8 : geo.frame(in: .local).midX * 0.7
                                    self.height = self.expanded ? 120 : 65
                                }
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(AppColors.blue))
                            .frame(width: geo.frame(in: .local).midX * 0.7, height: 65)
                            .overlay(DisabledView(width: geo.frame(in: .local).midX * 0.7, height: 65))
                            .padding(.top, 20)
                    }
                    Spacer()
                }.padding(.leading, 20)
                Spacer()
            }.onAppear{
                self.width = geo.frame(in: .local).midX * 0.7
                self.height = 65 //geo.frame(in: .local).midY * 0.25
            }
        }
    }
}

struct DisabledView: View {
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack{
            ZStack(alignment: .center)
            {
                VStack {
              //  RoundedRectangle(cornerRadius: 5, style: .continuous)
                   RoundedCorners(tl: 5, tr: 5, bl: 0, br: 0).fill(Color(AppColors.gray)).frame(width: self.width, height:  25)
                    Spacer()
                }
                VStack(alignment: .center, spacing: 0) {
                    Image(uiImage: UIImage(named: "exclamation")!).resizable().scaledToFit()
                    Text("No readings").padding(.bottom, 3)
                }.padding(.top, 10)
            //    Spacer()
            }.foregroundColor(.white)
            Spacer()
        }.padding(.leading, 8)
    }
}


struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        return path
    }
}
