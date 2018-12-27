//
//  MapViewModel.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//
import RxSwift

class MapViewModel {
    var mapViewStateObservable : Observable<MapViewState> {
        return mapViewState.asObservable()
    }
    private let disposeBag = DisposeBag()
    private var mapViewState : PublishSubject<MapViewState> = PublishSubject<MapViewState>()
    
    let getNearFlightsUseCase = GetFlightsNearUseCase()
    
    
    func getFlightsNear(lat: Double, lon: Double) {
        mapViewState.onNext(MapViewState.getFlightsStarted)
        
        _ = getNearFlightsUseCase.getFlightsNear(lat: lat, lon: lon).subscribe(onNext: { flights in

            if flights.isEmpty {
                self.mapViewState.onNext(MapViewState.getFlightsError(message: StringUtils.capitalizeFirstChar(NSLocalizedString("no_flights", comment: "no_flights"))))
                return
            }
        self.mapViewState.onNext(MapViewState.getFlightsEnded(flights: flights))
        }, onError: { (error) in
            #if DEBUG
            print("ERROR: \(error.localizedDescription)")
            #endif
            self.mapViewState.onNext(MapViewState.getFlightsError(message: NSLocalizedString("server_error", comment: "server error")))
        }).disposed(by: disposeBag)
    }
}
