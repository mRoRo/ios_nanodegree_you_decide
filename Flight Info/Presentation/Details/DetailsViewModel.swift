//
//  DetailsViewModel.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift
import CoreLocation

class DetailsViewModel {

    internal var detailsViewStateObservable : Observable<DetailsViewState> {
        return detailsViewState.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    private var detailsViewState : PublishSubject<DetailsViewState> = PublishSubject<DetailsViewState>()
    private let getFlightTrackUseCase = GetFlightTrackUseCase()
    
    
    // MARK: - WS
    func getFlightTrack(id: String) {
        detailsViewState.onNext(DetailsViewState.getFlightTrackStarted)
        
        _ = getFlightTrackUseCase.getFlightTrack(id: id)
            .subscribe(onNext: { flightTrack in
                
                guard let flightTrack = flightTrack else{
                    self.detailsViewState.onNext(DetailsViewState.getFlightTrackError(message: StringUtils.capitalizeFirstChar(NSLocalizedString("no_details", comment: "no_details"))))
                    return
                }
                self.detailsViewState.onNext(DetailsViewState.getFlightTrackEnded(flightTrack: flightTrack))
                
            }, onError: { (error) in
                #if DEBUG
                print("ERROR: \(error.localizedDescription)")
                #endif
                self.detailsViewState.onNext(DetailsViewState.getFlightTrackError(message: NSLocalizedString("server_error", comment: "server error")))
            }).disposed(by: disposeBag)
    }
}

