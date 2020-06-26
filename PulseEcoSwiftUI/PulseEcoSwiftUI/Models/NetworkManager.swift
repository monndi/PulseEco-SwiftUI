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
    
    
    @Published var sensors = [SensorModel]()
    @Published var cityOverallValues = CityOverallValues()
    
    var delegate: NetworkManagerDelegate?
    
    func fetchSensors(cityName: String) {
        if let url = URL(string: "https://\(cityName).pulse.eco/rest/sensor") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(SensorsResult.self, from: safeData)
                            //                             DispatchQueue.main.async {
                            //                                  self.sensors = results
                            //
                            //                             }
                            self.delegate?.didRecievedData(data: results)
                            
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
                
            }
            task.resume()
            
            
        }
    }
    func fetchSensors1(cityName: String, completion: @escaping ([SensorModel]) -> ()) {
        if let url = URL(string: "https://\(cityName).pulse.eco/rest/sensor") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(SensorsResult.self, from: safeData)
                            DispatchQueue.main.async {
                                completion(results)
                            }
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
            }
            task.resume()
            
            
        }
    }
    
    func fetchCityOverallValues(cityName: String) {
        if let url = URL(string: "https://\(cityName).pulse.eco/rest/overall") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(CityOverallValues.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                
                                self.cityOverallValues = results
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
                
            }
            task.resume()
            
            
        }
    }
    
    func fetchCityOverallValues1(cityName: String, completion: @escaping (CityOverallValues) -> ()) {
        if let url = URL(string: "https://\(cityName).pulse.eco/rest/overall") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(CityOverallValues.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                
                                completion(results)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
                
            }
            task.resume()
            
            
        }
    }
    func fetchSensorValues(sensorID: String){
        
        if let url = URL(string: "https://skopje.pulse.eco/rest/dataRaw?sensorId=\(1002)&type=pm10&from=2020-06-09T02:00:00%2b01:00&to=2020-06-10T12:00:00%2b01:00") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(SensorResults.self, from: safeData)
                            
                            for r in results {
                                print(r.sensorId!)
                            }
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
                
            }
            task.resume()
            
        }
    }
    func fetchAllCities(completion: @escaping ([CityModel]) -> ()) {
        if let url = URL(string: "https://skopje.pulse.eco/rest/city") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                
                                completion(results)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
                
            }
            task.resume()
            
            
        }
    }
    func getMeasures(completion: @escaping ([Measure]) -> ()) {
        if let url = URL(string: "https://pulse.eco/rest/measures") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Measures.self, from: safeData)
                            DispatchQueue.main.async {
                                print(results[0].buttonTitle)
                                completion(results)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "")
                }
                
            }
            task.resume()
            
            
        }
    }
    func getCities1() -> AnyPublisher<[CityModel], Error> {
        guard let url = URL(string:"https://skopje.pulse.eco/rest/city") else {
            fatalError()
        }
        return URLSession.shared.dataTaskPublisher(for: url).map{
            $0.data
        }
        .decode(type: [CityModel].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
        
    }
    
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
    
}

