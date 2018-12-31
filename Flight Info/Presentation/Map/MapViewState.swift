//
//  MapViewState.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

enum MapViewState {
    
    case getFlightsStarted
    case getFlightsEnded(flights: [NearFlight])
    case error(message: String)
}
