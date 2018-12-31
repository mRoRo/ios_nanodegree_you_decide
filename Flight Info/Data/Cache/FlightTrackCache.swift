//
//  FlightTrackCache.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

class FlightTrackCache: FlightTrackRepository {
    
    let dataSource: FlightTrackDataSource
    
    init(dataSource: FlightTrackDataSource) {
        self.dataSource = dataSource
    }
    
    func getFlightTrack(id: String) -> Observable<FlightTrack?> {
        return dataSource.getFlightTrack(id: id)
            .map {entity -> FlightTrack? in
                return FlightTrackMapper.getFlightTrack(from: entity)
        }
    }
}
