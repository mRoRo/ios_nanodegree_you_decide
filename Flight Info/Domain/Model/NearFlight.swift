//
//  NearFlight.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

struct NearFlight: Codable {
    let id: Int
    let positions: [FlightPosition]
    let name: String
}

struct FlightPosition: Codable {
    let lon, lat: Double?
    let speedMph, altitudeFt: Int?
    let date: String?
}
