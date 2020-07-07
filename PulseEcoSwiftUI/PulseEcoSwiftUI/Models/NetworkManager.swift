//
//  NetworkManager.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/10/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
   
     // MARK: - New
    
    func downloadMeasures() -> AnyPublisher<[Measure], Error> {
            guard let url = URL(string: "https://pulse.eco/rest/measures") else {
                fatalError("Invalid URL")
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Measure].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    func downloadSensors(cityName: String) -> AnyPublisher<[SensorModel], Error> {
            guard let url = URL(string: "https://\(cityName).pulse.eco/rest/sensor") else {
                fatalError("Invalid URL")
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [SensorModel].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    func downloadOverallValuesForCity(cityName: String) -> AnyPublisher<CityOverallValues, Error> {
            guard let url = URL(string: "https://\(cityName).pulse.eco/rest/overall") else {
                fatalError("Invalid URL")
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CityOverallValues.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    func downloadDataForSensors(cityName: String) -> AnyPublisher<[Sensor], Error> {
            guard let url = URL(string: "https://\(cityName).pulse.eco/rest/current") else {
                fatalError("Invalid URL")
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Sensor].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

