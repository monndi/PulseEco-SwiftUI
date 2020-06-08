//
//  MapView.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/1/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import SwiftUI
import MapKit



class Pin: NSObject, MKAnnotation {
    var title: String?
    var value: Int?
    var color: UIColor {
        switch value {
        case (0...10)?:
            return .systemGreen
        case (11...20)?:
            return .systemOrange
        case (20...30)?:
            return .systemRed
        default:
            return .purple
        }
    }
    
    var coordinate: CLLocationCoordinate2D
   
    init(title: String?, value: Int?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.value = value
        self.coordinate = coordinate
        
    }

}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView
    
    init(_ control: MapView) {
        self.mapViewController = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("Show/Hide", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        
        let annotatonView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
      
        
        annotatonView.canShowCallout = true
        annotatonView.image = UIImage(named: "marker")?.withTintColor(UIColor.red)
        annotatonView.calloutOffset = CGPoint(x: -5, y: 5)
        annotatonView.rightCalloutAccessoryView = button
        return annotatonView

//        guard let annotation = annotation as? Pin else {
//            return nil
//        }
//        let identifier = "\(annotation.coordinate)"
//        var view: MKMarkerAnnotationView
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UILabel()
//            view.markerTintColor = annotation.color
//            view.glyphText = "\(annotation.value!)"
//
//       }
//         return view
        
    }
   @objc func buttonAction(sender: UIButton!) {
    mapViewController.showDetails.toggle()
   }
   
  
}

struct MapView: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D
    @Binding var showDetails: Bool
    
    var pins = [Pin(title: "Pin1", value: 5, coordinate: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)), Pin(title: "Pin2", value: 13, coordinate: CLLocationCoordinate2D(latitude: 35.013333, longitude: -116.17358)), Pin(title: "Skopje", value: 6, coordinate: CLLocationCoordinate2D(latitude: 41.998, longitude: 21.4254)), Pin(title: "Bitola", value: 13, coordinate: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868))]
    
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
      
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
//      let coordinate = CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
    // let annotation = MKPointAnnotation()
    //  annotation.coordinate = coordinate
       
        uiView.setRegion(region, animated: true)
        
       
        for pin in pins {
           uiView.addAnnotation(pin)
        }
       
        uiView.mapType = MKMapType.standard
        uiView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 500000)
        uiView.setCameraZoomRange(zoomRange, animated: true)
        
        
    }
    
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(), showDetails: .constant(false))
    }
}
