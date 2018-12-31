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
                let flights =  FlightNearbyMapper.getFlights(from: entity)
                self.setFlightsNear(flights:flights)
                return self.getPersistedFlightsNear()
        }
    }
    
    func setFlightsNear(flights: [NearFlight]) {
        dataSource.setFlightsNear(flights: flights)
    }
    
    func getPersistedFlightsNear() -> [NearFlight] {
        return dataSource.getPersistedFlightsNear()
    }
}
