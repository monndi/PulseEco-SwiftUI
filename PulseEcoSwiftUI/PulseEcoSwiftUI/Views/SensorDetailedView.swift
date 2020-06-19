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
    var body: some View {
        VStack{
            GeometryReader { geo in
                VStack {
                    Rectangle()
                        .frame(width: 50, height: 3.0, alignment: .bottom)
                        .foregroundColor(Color.black).padding(.top)
                    DetailTop(sensorDetailsVM: SensorDetailsVM()).padding(.top)
                    Spacer()
                    Text("Disclaimer: This data shown ...").padding(.bottom, 50)
                }
            }.background(Color(UIColor.white))
                .cornerRadius(40)
                .offset(y: self.showDetails ? UIHeight/3  : UIHeight/17)
                .padding(.top, UIHeight/3)
                .animation(.default)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            //action
                    }
                        
                    .onEnded { _ in
                        self.showDetails.toggle()
                    }
            )
            
        }
    }
}
struct DetailTop: View {
    var sensorDetailsVM: SensorDetailsVM
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: sensorDetailsVM.image)
                    Text(sensorDetailsVM.title).foregroundColor(Color.gray)
                }
                HStack {
                    Text(sensorDetailsVM.value).font(.system(size: 40))
                    Text(sensorDetailsVM.unit).padding(.top, 10)
                    Spacer()
                    VStack (alignment: .leading) {
                        Text(sensorDetailsVM.time)
                        Text(sensorDetailsVM.date).foregroundColor(Color.gray)
                    }
                    Image(systemName: "star")
                }
            }
            
        }.padding([.leading, .trailing], 20)
    }
}

