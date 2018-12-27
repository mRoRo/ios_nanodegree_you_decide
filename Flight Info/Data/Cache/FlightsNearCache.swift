//
//  FlightsNearCache.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

class FlightsNearCache: FlightsNearRepository {
    
    let dataSource: FlightsNearDataSource
    
    init(dataSource: FlightsNearDataSource) {
        self.dataSource = dataSource
    }
    
    func getFlightsNear(lat: Double, lon: Double) -> Observable<[NearFlight]> {
        return dataSource.getFlightsNear(lat:lat, lon:lon)
            .map {entity -> [NearFlight] in
                return FlightNearbyMapper.getFlights(from: entity)
        }
    }
}
