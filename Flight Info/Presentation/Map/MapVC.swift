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
    
    private let disposeBag = DisposeBag()
    private var viewModel: MapViewModel = MapViewModel()
    internal var activityIndicator = UIActivityIndicatorView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupViewStateObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO get real values
        centerMap(CLLocationCoordinate2DMake(41.649635, -4.729317))
        viewModel.getFlightsNear(lat: 41.649635, lon:  -4.729317)
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
                    
                case .getFlightsError(let message):
                    self.showAlert(message: message)
                    self.hideActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func refreshAction(_ sender: Any) {
        // TODO get real values
        viewModel.getFlightsNear(lat: 41.649635, lon:  -4.729317)
    }
    
}

