//
//  CityList.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/3/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import MapKit

struct CityList: View {
    @Binding var locationClicked: Bool
    @Binding var cityName: String
    @Binding var city: City
    var cities = cities1
    
    var body: some View {
        
        List(cities.filter {
            cityName.isEmpty ? true :
                 $0.name.localizedCaseInsensitiveContains(cityName)
            }, id: \.id) { city in
                CityRow(city: city).onTapGesture {
                    self.locationClicked = false
                    self.cityName = ""
                    self.city = city
                }.opacity(1.0)
                
        }.onAppear(perform: { UITableView.appearance().separatorColor = .clear })
       
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        CityList(locationClicked: .constant(true), cityName: .constant(""), city: .constant(City(id: 1, name: "name", coordinates: Coordinates(latitude: 2.0, longitude: 2.0), country: "country", description: "desscription")))
    }
}
