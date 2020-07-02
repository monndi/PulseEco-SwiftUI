//
//  MapView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/16/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView
    init(_ control: MapView) {
        self.mapViewController = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        guard let annotation = annotation as? SensorVM else {
            return nil
        }
        
        let tapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.sensor = annotation
        
        let annotatonView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
        annotatonView.addGestureRecognizer(tapGestureRecognizer)
        
        annotatonView.canShowCallout = true
        let pinImage = UIImage(named: "marker")!.withTintColor(UIColor.init(red: 0.00, green: 0.58, blue: 0.20, alpha: 1))
        let size = CGSize(width: 35, height: 48)
        UIGraphicsBeginImageContext(size)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

        let uiImage = self.textToImage(drawText: String(annotation.value), inImage: resizedImage!, atPoint: CGPoint(x: 14, y: 13))
        
        annotatonView.image = uiImage
       // annotatonView.calloutOffset = CGPoint(x: -5, y: 5)
        
        return annotatonView
        
    }
    
    class MyTapGesture: UITapGestureRecognizer {
        var sensor: SensorVM?
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: MyTapGesture)
    {
        mapViewController.appVM.showSensorDetails = true
        mapViewController.appVM.sensorSelected = tapGestureRecognizer.sensor
        mapViewController.appVM.updateMap = false
    }
    @objc func triggerTouchAction(tapGestureRecognizer: UITapGestureRecognizer) {
        mapViewController.appVM.showSensorDetails = false
    }
}

struct MapView: UIViewRepresentable {
    
    @ObservedObject var mapVM: MapVM
    @EnvironmentObject var appVM: AppVM
   
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = mapVM.coordinates
        
        
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        if appVM.updateMap {
            uiView.setRegion(region, animated: true)
        }
        
        let pins:[SensorVM] = mapVM.sensors.map{
            sensor in
            let coordinates = sensor.position.split(separator: ",")
            return SensorVM(title: sensor.description,
                            sensorID: sensor.sensorID,
                            value: "2",
                            coordinate: CLLocationCoordinate2D(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!))
        }
        for pin in pins {
            uiView.addAnnotation(pin)
        }
        
        uiView.mapType = MKMapType.standard
                uiView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: Double(mapVM.intialZoomLevel*10000)) //100000))
        uiView.setCameraZoomRange(zoomRange, animated: true)
        let tapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action:#selector(Coordinator.triggerTouchAction(tapGestureRecognizer:)))
        uiView.addGestureRecognizer(tapGestureRecognizer)
    }
}


