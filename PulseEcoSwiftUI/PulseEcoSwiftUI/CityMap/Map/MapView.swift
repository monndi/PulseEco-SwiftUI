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
        let pinImage = UIImage(named: "marker")?.withTintColor(annotation.color) ?? UIImage()
        let size = CGSize(width: 35, height: 48)
        UIGraphicsBeginImageContext(size)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        let uiImageShadowed = resizedImage.addShadow()
        let uiImage = self.textToImage(drawText: String(annotation.value), inImage: uiImageShadowed, atPoint: CGPoint(x: 11, y: 13))
       
        annotatonView.image = uiImage
       // annotatonView.calloutOffset = CGPoint(x: -5, y: 5)
        
        return annotatonView
        
    }
    
    class MyTapGesture: UITapGestureRecognizer {
        var sensor: SensorVM?
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12) ?? UIFont()
        
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
        mapViewController.appVM.selectedSensor = tapGestureRecognizer.sensor
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
    
    @ObservedObject var viewModel: MapVM
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
        let coordinate = self.viewModel.coordinates
        
        
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        if self.appVM.updateMapRegion {
            uiView.setRegion(region, animated: true)
        }
        if self.appVM.updateMapAnnotations {
            uiView.removeAnnotations(uiView.annotations)
            for pin in self.viewModel.sensors {
                uiView.addAnnotation(pin)
            }
        }
        
        uiView.mapType = MKMapType.standard
        uiView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: Double(self.viewModel.intialZoomLevel*5000)) //100000))
        uiView.setCameraZoomRange(zoomRange, animated: true)
        let tapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action:#selector(Coordinator.triggerTouchAction(tapGestureRecognizer:)))
        uiView.addGestureRecognizer(tapGestureRecognizer)
    }
}


extension UIImage {

    func addShadow(blurSize: CGFloat = 6.0) -> UIImage {

        let shadowColor = UIColor(white:0.0, alpha:0.5).cgColor

        let context = CGContext(data: nil,
                                width: Int(self.size.width + blurSize),
                                height: Int(self.size.height + blurSize),
                                bitsPerComponent: self.cgImage!.bitsPerComponent,
                                bytesPerRow: 0,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

        context.setShadow(offset: CGSize(width: blurSize/2,height: -blurSize/2),
                          blur: blurSize,
                          color: shadowColor)
        context.draw(self.cgImage!,
                     in: CGRect(x: 0, y: blurSize, width: self.size.width, height: self.size.height),
                     byTiling:false)

        return UIImage(cgImage: context.makeImage()!)
    }
}
