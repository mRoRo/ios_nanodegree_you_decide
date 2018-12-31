//
//  FlightTrackDataSource.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

protocol FlightTrackDataSource {
    func getFlightTrack(id: String) -> Observable<FSFlightTrackResponse>
}
