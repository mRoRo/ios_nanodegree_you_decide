//
//  MapViewModel.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//
import RxSwift
import CoreLocation

class MapViewModel: NSObject, CLLocationManagerDelegate {
    internal var refLocation : CLLocationCoordinate2D? = nil
    internal var mapViewStateObservable : Observable<MapViewState> {
        return mapViewState.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    private var mapViewState : PublishSubject<MapViewState> = PublishSubject<MapViewState>()
    private let getNearFlightsUseCase = GetFlightsNearUseCase()
    private let locationManager = CLLocationManager()
    
    // MARK: - Initializers
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - WS
    func getFlightsNear() {
        
        guard let refLocation = refLocation else {
            self.mapViewState.onNext(MapViewState.error(message: StringUtils.capitalizeFirstChar(NSLocalizedString("no_user_location", comment: "no_user_location"))))
            return
        }
        mapViewState.onNext(MapViewState.getFlightsStarted)
        
        _ = getNearFlightsUseCase.getFlightsNear(lat: refLocation.latitude, lon: refLocation.longitude)
            .subscribe(onNext: { flights in

            if flights.isEmpty {
                self.mapViewState.onNext(MapViewState.error(message: StringUtils.capitalizeFirstChar(NSLocalizedString("no_flights", comment: "no_flights"))))
                return
            }
        self.mapViewState.onNext(MapViewState.getFlightsEnded(flights: flights))
                
        }, onError: { (error) in
            #if DEBUG
            print("ERROR: \(error.localizedDescription)")
            #endif
            self.mapViewState.onNext(MapViewState.error(message: NSLocalizedString("server_error", comment: "server error")))
        }).disposed(by: disposeBag)
    }
}
