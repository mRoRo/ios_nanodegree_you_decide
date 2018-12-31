//
//  FlightTrack.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//
enum FlightStatus: String {
    case active = "A"
    case cancelled = "C"
    case diverted = "D"
    case dataSourceNeeded =  "DN"
    case landed = "L"
    case notOperational = "NO"
    case redirected = "R"
    case scheduled = "S"
    case unknown = "U"
}

struct FlightTrack {
    let id: Int
    let name: String
    let status: FlightStatus
    let departureAirport: String
    let arrivalAirport: String
    let airline: String
    let departureGateDelayMinutes: String?
    let departureRunwayDelayMinutes: String?
    let arrivalGateDelayMinutes: String?
    let arrivalRunwayDelayMinutes: String?
}

