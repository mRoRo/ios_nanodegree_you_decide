//
//  FlightTrackMapper.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//
import Foundation

class FlightTrackMapper {
    class func getFlightTrack(from entity: FSFlightTrackResponse?) -> FlightTrack? {
        guard let fsFlightTrack = entity?.flightStatus else {
            return nil
        }
        
        // check id
        guard let id = fsFlightTrack.flightID else {
            return nil
        }
        
        // get flightName
        var name = "-"
        if let flightNumber = fsFlightTrack.flightNumber,
            let carrierCode = fsFlightTrack.carrierFSCode{
            name = String(carrierCode + flightNumber)
        }
        
        // get status
        let flightStatusString = fsFlightTrack.status!
        let flightStatus = FlightStatus(rawValue: flightStatusString) ?? .unknown
        
        // get airlines
        var airlineString = ""
        if let airlines = entity?.appendix?.airlines {
            for airLine in airlines {
                if let airLineName = airLine.name {
                    // add "," if there's more than one airLine
                    let joinCharacter = airlineString.count == 0 ? "" : ", "
                    airlineString = airlineString + joinCharacter + airLineName
                }
            }
        }
        else {
           airlineString = "-"
        }
        
        // get dept airport
        var deptAirportString = "-"
        var arrivalAirportString = "-"
        if let airports = entity?.appendix?.airports {
            
            // dept airport
            if let deptAirportCode = entity?.flightStatus?.departureAirportFSCode {
                let deptAirport = airports.filter {$0.fs == deptAirportCode}.first
                deptAirportString = deptAirport?.name ?? "-"
                
                // arrival airport
                if let arrivalAirportCode = entity?.flightStatus?.arrivalAirportFSCode {
                    let arrivalAirport = airports.filter {$0.fs == arrivalAirportCode}.first
                    arrivalAirportString = arrivalAirport?.name ?? "-"
                }
            }
        }
            
        // delays
        let noDelayString = NSLocalizedString("no_delay", comment: "no_delay")
        var departureGateDelayMinutes = noDelayString
        var departureRunwayDelayMinutes = noDelayString
        var arrivalGateDelayMinutes = noDelayString
        var arrivalRunwayDelayMinutes = noDelayString
        if let delays = entity?.flightStatus?.delays {
            
            if let deptGateDelay = delays.fsDepartureGateDelayMinutes {
                departureGateDelayMinutes = String(format: "%dmin",deptGateDelay)
            }
            if let arrivalGateDelay = delays.fsArrivalGateDelayMinutes {
                arrivalGateDelayMinutes = String(format: "%dmin",arrivalGateDelay)
            }
            if let deptRunwayDelay = delays.fsDepartureRunwayDelayMinutes {
                departureRunwayDelayMinutes = String(format: "%dmin",deptRunwayDelay)
            }
            if let arrivalRunwayDelay = delays.fsArrivalRunwayDelayMinutes {
                arrivalRunwayDelayMinutes = String(format: "%dmin",arrivalRunwayDelay)
            }
        }
        
        return FlightTrack(id: id, name: name, status: flightStatus, departureAirport: deptAirportString, arrivalAirport: arrivalAirportString, airline: airlineString, departureGateDelayMinutes: departureGateDelayMinutes,
            departureRunwayDelayMinutes: departureRunwayDelayMinutes,
            arrivalGateDelayMinutes: arrivalGateDelayMinutes,
            arrivalRunwayDelayMinutes: arrivalRunwayDelayMinutes)
    }
}

