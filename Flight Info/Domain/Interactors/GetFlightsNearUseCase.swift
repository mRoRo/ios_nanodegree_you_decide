//
//  GetFlightsNearUseCase.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

class GetFlightsNearUseCase {
    
    func getFlightsNear(lat: Double, lon: Double) -> Observable<[NearFlight]> {
        
        let dataSource = FlightsNearRequest.init()
        let repositoty = FlightsNearCache(dataSource:dataSource)
        
        return repositoty.getFlightsNear(lat:lat, lon:lon)
    }
}
