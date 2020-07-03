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
        let pinImage = UIImage(named: "marker")!.withTintColor(annotation.color)
        let size = CGSize(width: 35, height: 48)
        UIGraphicsBeginImageContext(size)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

        let uiImage = self.textToImage(drawText: String(annotation.value), inImage: resizedImage!, atPoint: CGPoint(x: 12, y: 13))
        
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
        mapViewController.appVM.updateMapRegion = false
        mapViewController.appVM.updateMapAnnotations = false
    }
    @objc func triggerTouchAction(tapGestureRecognizer: UITapGestureRecognizer) {
        mapViewController.appVM.showSensorDetails = false
        mapViewController.appVM.updateMapRegion = false
        mapViewController.appVM.updateMapAnnotations = false
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
        
        if appVM.updateMapRegion {
            uiView.setRegion(region, animated: true)
        }
        if appVM.updateMapAnnotations {
            uiView.removeAnnotations(uiView.annotations)
            for pin in mapVM.sensors {
                uiView.addAnnotation(pin)
            }
        }
        
        uiView.mapType = MKMapType.standard
        uiView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: Double(mapVM.intialZoomLevel*5000)) //100000))
        uiView.setCameraZoomRange(zoomRange, animated: true)
        let tapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action:#selector(Coordinator.triggerTouchAction(tapGestureRecognizer:)))
        uiView.addGestureRecognizer(tapGestureRecognizer)
    }
}


