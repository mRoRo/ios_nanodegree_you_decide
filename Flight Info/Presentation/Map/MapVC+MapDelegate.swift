//
//  MapVC+MapDelegate.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import MapKit

extension MapVC: MKMapViewDelegate {
    
    func updateFlightMarkers(flights: [NearFlight]) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotations = flights.compactMap {
            flight -> MKPointAnnotation in
            guard let position = flight.positions.last,
                let lat = position.lat,
                let lon = position.lon else {
                    return MKPointAnnotation()
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
            annotation.title = flight.name
            
            return annotation
        }
        
        mapView.addAnnotations(annotations)
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.image = #imageLiteral(resourceName: "planeBlue")
            pinView!.canShowCallout = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    func centerMap(_ coordinate: CLLocationCoordinate2D) {
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20))
        mapView.setRegion(mapRegion, animated: true)
    }
}
