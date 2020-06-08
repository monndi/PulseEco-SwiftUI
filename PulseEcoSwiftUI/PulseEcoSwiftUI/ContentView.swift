//
//  ContentView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 5/28/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//
import MapKit
import SwiftUI

let UIWidthScreen = UIScreen.main.bounds.width

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    var list = ["PM10", "PM25", "Noise", "Temperture", "Humidity", "Pressure", "NO2", "O3"]
    @State private var index: Int = 0
    @State private var selectedItem: String = "PM10"
    @State private var showDisclaimerView = false
    @State private var locaitonClicked = false
    @State var cityName: String = ""
    @State var city: City = cities1[1]
    @State var showDetailedView = false
    var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
                VStack {
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(list, id: \.self) { item in
                                
                                VStack {
                                    HeaderTabButton(title: item, selectedItem: self.$selectedItem)
                                    
                                }
                                
                            }
                        }
                        
                    }.background(Color.white.shadow(color: Color.gray, radius: 5, x: 0, y: 0))
                    
                    ZStack {
                        
                        VStack {
                            MapView(coordinate:  city.locationCoordinate, showDetails: self.$showDetailedView)
                                .edgesIgnoringSafeArea(.all)
                            
                            
                        }
                        
                        VStack(alignment: .trailing) {
                            Spacer()
                            HStack {
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(Color(UIColor.lightGray))
                                    .frame(width: 220, height: 25)
                                    .overlay(Text("Crowdsourced sensor data")
                                        .foregroundColor(Color.white)
                                )
                                    .padding(.bottom, 35)
                                    .onTapGesture {
                                        self.showDisclaimerView.toggle()
                                }
                                
                            }.padding(.trailing, 15)
                            
                        }
                        AverageView()
                        VStack {
                            if locaitonClicked == true {
                                CityList(locationClicked: self.$locaitonClicked, cityName: self.$cityName, city: self.$city).opacity(0.9)
                            }
                        }
                        if showDetailedView == true {
                            SensorDetailedView()
                        }
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.locaitonClicked = true
                    
                }) {
                    
                    Text(self.locaitonClicked ? "" : city.name)
                        .bold()
                    
                    
                }.accentColor(Color.black), trailing: Image(uiImage: UIImage(named: "logo-pulse")!).imageScale(.large).padding(.trailing, (UIWidthScreen)/2.6).onTapGesture {
                    //action
                    }
                )
                    .sheet(isPresented: $showDisclaimerView) {
                        CrowdSourcedSensorData().environment(\.managedObjectContext, self.moc)
                }
                
            }
            ZStack {
                if self.locaitonClicked {
                    SearchView(cityName: self.$cityName).padding(.top, 0)
                }
            }
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//                                            Button(action: {
//                                          self.index = self.list.firstIndex(of: item)!
//                                      }) {
//                                          Text("\(item)")
//
//      //                                        .underline(self.index == self.list.firstIndex(of: item), color: Color.purple)
//
//                                      }
//                                          .accentColor(Color.black)
//                                          .padding([.top, .leading, .trailing], 10)
//
//                                         // if self.index == self.list.firstIndex(of: item) {
//                                              Rectangle()
//                                                .frame(height: 3.0, alignment: .bottom)
//                                                  .foregroundColor(self.index == self.list.firstIndex(of: item) ? Color.purple : Color.white)
//
//                                         // }
//
