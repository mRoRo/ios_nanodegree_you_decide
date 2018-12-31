//
//  GetFlightTrackUseCase.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

class GetFlightTrackUseCase {
    
    func getFlightTrack(id: String) -> Observable<FlightTrack?> {
        
        let dataSource = FlightTrackRequest.init()
        let repositoty = FlightTrackCache(dataSource:dataSource)
        
        return repositoty.getFlightTrack(id:id)
    }
}

