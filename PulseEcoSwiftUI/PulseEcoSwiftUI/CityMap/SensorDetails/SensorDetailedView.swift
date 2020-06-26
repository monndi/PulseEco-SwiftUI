//
//  SensorDetailedView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI

struct SensorDetailedView: View {
    @State var showDetails: Bool = true
    @EnvironmentObject var appVM: AppVM
    var geometry: GeometryProxy
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    Rectangle()
                        .frame(width: 50, height: 3.0, alignment: .bottom)
                        .foregroundColor(Color.black).padding(.top, 10)
                    DetailTop(sensorDetailsVM: SensorDetailsVM(sensorID: self.appVM.sensorSelected!.sensorID), height: geo.size.height).padding(.top, 5)
                    //                    LineGraph(dataPoints: [0, 1, 2, 3])
                    //                    .trim(to: 0)
                    //                    .stroke(Color.red, lineWidth: 2)
                    //                    .aspectRatio(16/9, contentMode: .fit)
                    //                    .border(Color.gray, width: 1)
                    //                    .padding()
                    Spacer()
                    Text("Disclaimer: This data shown ...").padding(.bottom, 20).frame(width: geo.size.width, height: geo.size.height / 6)
                }
            }.background(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0).fill(Color(UIColor.white)))
                .offset(y: self.showDetails ? UIHeight/3.2  : .zero)
                .padding(.top, UIHeight/3)
                .animation(.default)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height < 0 {
                                self.showDetails = false
                            } else {
                                self.showDetails = true
                            }
                    }
            )
        }
    }
}
struct DetailTop: View {
    var sensorDetailsVM: SensorDetailsVM
    var height: CGFloat
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: UIImage(named: sensorDetailsVM.image)!).resizable().scaledToFit()
                    Text("\(sensorDetailsVM.title) \(sensorDetailsVM.sensorID)").foregroundColor(Color.gray)
                }.frame(height: height/15)
                HStack {
                    Text(sensorDetailsVM.value).font(.system(size: height/10))
                    Text(sensorDetailsVM.unit).padding(.top, 10)
                    Spacer()
                    VStack (alignment: .leading) {
                        Text(sensorDetailsVM.time)
                        Text(sensorDetailsVM.date).foregroundColor(Color.gray)
                    }
                    Image(uiImage: UIImage(named: sensorDetailsVM.image)!).resizable().scaledToFit()
                }.frame(height: height/15)
            }
        }.padding([.leading, .trailing], 20)
    }
}


struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}
