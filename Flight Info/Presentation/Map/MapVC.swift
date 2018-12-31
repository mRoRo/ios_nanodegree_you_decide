//
//  MapVC.swift
//  Flight Info
//
//  Created by Maro on 24/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapVC: UIViewController, AlertPresenter, ActivityIndicatorPresenter {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    enum MarkerType {
        case plane
        case reference
        case unknown
    }
    internal var markerType: MarkerType = .unknown
    
    internal var activityIndicator = UIActivityIndicatorView()

    private let disposeBag = DisposeBag()
    private var viewModel: MapViewModel = MapViewModel()
    internal var planeAnnotations: [MKAnnotation]? = nil
    internal var refAnnotation: MKAnnotation? = nil

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupViewStateObserver()
    }
    
    // MARK: - Rx
    private func setupViewStateObserver() {
        viewModel.mapViewStateObservable
            .subscribe(onNext: { state in
                switch(state) {
                    
                case .getFlightsStarted:
                    self.showActivityIndicator()
                    
                case .getFlightsEnded(let flights):
                    self.updateFlightMarkers(flights: flights)
                    self.hideActivityIndicator()
                    
                case .error(let message):
                    self.showAlert(message: message)
                    self.hideActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func refreshAction(_ sender: Any) {
        viewModel.getFlightsNear()
    }
    
    @IBAction func longPressDetected(_ sender: Any) {
    
        if let longPressRecognizer = sender as? UILongPressGestureRecognizer {
            if longPressRecognizer.state == .began {
                let point = longPressRecognizer.location(in: mapView)
                viewModel.refLocation = mapView.convert(point, toCoordinateFrom: mapView)
                guard let refLocation = viewModel.refLocation else {
                    return
                }
                
                updateRefMarker(coordinate: refLocation)
            }
        }
    }
    
    // MARK: - Navigation
    func navigateToFlightDetails(flightId: String, flightName: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.flightId = flightId
        vc.flightName = flightName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UI Changes
    func centerMap(_ coordinate: CLLocationCoordinate2D) {
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20))
        mapView.setRegion(mapRegion, animated: true)
    }
}

