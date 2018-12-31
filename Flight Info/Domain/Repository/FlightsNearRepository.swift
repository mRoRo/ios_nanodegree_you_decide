//
//  FlightsNearRepository.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

protocol FlightsNearRepository {
    func getFlightsNear(lat: Double, lon: Double)  -> Observable<[NearFlight]>
    func setFlightsNear(flights: [NearFlight])
}
