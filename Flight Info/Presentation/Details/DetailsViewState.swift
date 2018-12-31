//
//  DetailsViewState.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

enum DetailsViewState {
    
    case getFlightTrackStarted
    case getFlightTrackEnded(flightTrack: FlightTrack)
    case getFlightTrackError(message: String)
}
