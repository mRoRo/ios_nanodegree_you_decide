//
//  FlightNearbyMapper.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

class FlightNearbyMapper {
    class func getFlights(from entity: FSNearFlightsResponse?) -> [NearFlight] {
        guard let fsFlights = entity?.flights else {
            return []
        }
        
        return fsFlights.compactMap {
            flight -> NearFlight? in
            
            // check id
            guard let id = flight.flightID else {
                return nil
            }
            
            // check positions
            guard let positions = flight.positions else {
                return NearFlight(id: id, positions: [], name: flight.callsign ?? "")
            }
            
            let mappedPositions =  positions.compactMap { position -> FlightPosition? in
                guard let lat = position.lat,
                let lon = position.lon,
                let speedMph = position.speedMph,
                let altitudeFt = position.altitudeFt,
                    let date = position.date else {
                        return nil
                }
                
                return FlightPosition(lon: lon, lat: lat, speedMph: speedMph, altitudeFt: altitudeFt, date: date)
            }
            
            return NearFlight(id: id, positions: mappedPositions, name: flight.callsign ?? "")
            
        }
    }
}
