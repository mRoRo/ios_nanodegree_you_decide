//
//  FSNearFlightsResponse.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//


import Foundation

struct FSNearFlightsResponse: Codable {
    let request: FSNearFlightsRequest?
    let appendix: FSNearFlightsAppendix?
    let flights: [FSFlight]?
    
    enum CodingKeys: String, CodingKey {
        case request, appendix
        case flights = "flightPositions"
    }
}

struct FSNearFlightsAppendix: Codable {
}

struct FSFlight: Codable {
    let flightID: Int?
    let callsign, tailNumber: String?
    let heading: Double?
    let source: FSSource?
    let positions: [FSPosition]?

    enum CodingKeys: String, CodingKey {
        case flightID = "flightId"
        case callsign, tailNumber, heading, source, positions
    }
}

struct FSPosition: Codable {
    let lon, lat: Double?
    let speedMph, altitudeFt: Int?
    let source: FSSource?
    let date: String?
}

enum FSSource: String, Codable {
    case derived = "derived"
}

struct FSNearFlightsRequest: Codable {
    let latitude, longitude, radiusMiles, maxFlights: FSRequestedItem?
    let extendedOptions: FSAppendix?
    let url: String?
}

struct FSRequestedItem: Codable {
    let requested: String?
    let interpreted: Double?
}
