//
//  MapVC+MapDelegate.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import MapKit
import Foundation

extension MapVC: MKMapViewDelegate {
    
    func updateFlightMarkers(flights: [NearFlight]) {
        
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
            annotation.subtitle = String(flight.id)

            
            return annotation
        }
        markerType = .plane
        if let planeAnnotations = planeAnnotations {
            mapView.removeAnnotations(planeAnnotations)
        }
        planeAnnotations = annotations
        mapView.addAnnotations(annotations)
    }
    
    func updateRefMarker(coordinate: CLLocationCoordinate2D) {

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = NSLocalizedString("ref_location", comment: "ref_location")
        
        markerType = .reference
        if let refAnnotation = refAnnotation {
            mapView.removeAnnotation(refAnnotation)
        }
        refAnnotation = annotation
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView: MKAnnotationView? = nil
        
        switch markerType {
        case .plane:
            let reuseId = "planePin"
            
            pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.image = #imageLiteral(resourceName: "planeBlue")
                pinView!.canShowCallout = true
                let calloutButton = UIButton(type: .detailDisclosure)
                calloutButton.tintColor = UIColor.udacityBlue
                pinView!.rightCalloutAccessoryView = calloutButton
            }
            else {
                pinView!.annotation = annotation
            }
            
        case .reference:
            let reuseId = "refPin"
            
            pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.image = #imageLiteral(resourceName: "pin")
                
            }
            else {
                pinView!.annotation = annotation
            }
            
        default:
            pinView = nil
        }

        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            guard let annotation =  view.annotation,
                let flightId = annotation.subtitle,
                let flightName = annotation.title else {
                    return
            }
            
            navigateToFlightDetails(flightId: flightId ?? "", flightName: flightName ?? "-")
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation!.title != NSLocalizedString("ref_location", comment: "ref_location") {
            view.image = #imageLiteral(resourceName: "planeRed")
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.annotation!.title != NSLocalizedString("ref_location", comment: "ref_location") {
            view.image = #imageLiteral(resourceName: "planeBlue")
        }
    }
}
