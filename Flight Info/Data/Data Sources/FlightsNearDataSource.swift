//
//  FlightsNearDataSource.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

protocol FlightsNearDataSource {
    func getFlightsNear(lat: Double, lon: Double) -> Observable<FSNearFlightsResponse>
    func setFlightsNear(flights: [NearFlight])
    func getPersistedFlightsNear() -> [NearFlight]
}
