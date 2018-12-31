//
//  FSFlightTrackResponse.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import Foundation

struct FSFlightTrackResponse: Codable {
    let request: FSFlightTrackRequest?
    let appendix: FSAppendix?
    let flightStatus: FSFlightStatus?
}

struct FSAppendix: Codable {
    let airlines: [FSAirline]?
    let airports: [FSAirport]?
    let equipments: [FSEquipment]?
}

struct FSAirline: Codable {
    let fs, iata, icao, name: String?
    let active: Bool?
    let phoneNumber: String?
}

struct FSAirport: Codable {
    let fs, iata, icao, name: String?
    let city, cityCode, countryCode, countryName: String?
    let regionName, timeZoneRegionName, localTime: String?
    let utcOffsetHours: Int?
    let latitude, longitude: Double?
    let elevationFeet, classification: Int?
    let active: Bool?
    let delayIndexURL, weatherURL: String?
    
    enum CodingKeys: String, CodingKey {
        case fs, iata, icao, name, city, cityCode, countryCode, countryName, regionName, timeZoneRegionName, localTime, utcOffsetHours, latitude, longitude, elevationFeet, classification, active
        case delayIndexURL = "delayIndexUrl"
        case weatherURL = "weatherUrl"
    }
}

struct FSEquipment: Codable {
    let iata, name: String?
    let turboProp, jet, widebody, regional: Bool?
}

struct FSFlightStatus: Codable {
    let flightID: Int?
    let carrierFSCode, flightNumber, departureAirportFSCode, arrivalAirportFSCode: String?
    let departureDate, arrivalDate: FSArrivalDate?
    let status: String?
    let schedule: FSSchedule?
    let operationalTimes: FSOperationalTimes?
    let codeshares: [FSCodeshare]?
    let delays: FSDelays?
    let flightDurations: FSFlightDurations?
    let airportResources: FSAirportResources?
    let flightEquipment: FSFlightEquipment?
    
    enum CodingKeys: String, CodingKey {
        case flightID = "flightId"
        case carrierFSCode = "carrierFsCode"
        case flightNumber
        case departureAirportFSCode = "departureAirportFsCode"
        case arrivalAirportFSCode = "arrivalAirportFsCode"
        case departureDate, arrivalDate, status, schedule, operationalTimes, codeshares,
        delays, flightDurations, airportResources, flightEquipment
    }
}

struct FSAirportResources: Codable {
    let departureTerminal, departureGate: String?
}

struct FSArrivalDate: Codable {
    let dateLocal, dateUTC: String?
    
    enum CodingKeys: String, CodingKey {
        case dateLocal
        case dateUTC = "dateUtc"
    }
}

struct FSCodeshare: Codable {
    let fsCode, flightNumber, relationship: String?
}

struct FSDelays: Codable {
    let fsDepartureGateDelayMinutes, fsDepartureRunwayDelayMinutes, fsArrivalGateDelayMinutes,
        fsArrivalRunwayDelayMinutes: String?
}

struct FSFlightDurations: Codable {
    let scheduledBlockMinutes, taxiOutMinutes: Int?
}

struct FSFlightEquipment: Codable {
    let scheduledEquipmentIataCode, actualEquipmentIataCode: String?
}

struct FSOperationalTimes: Codable {
    let publishedDeparture, publishedArrival, scheduledGateDeparture, estimatedGateDeparture: FSArrivalDate?
    let actualGateDeparture, estimatedRunwayDeparture, actualRunwayDeparture, scheduledGateArrival: FSArrivalDate?
    let estimatedRunwayArrival: FSArrivalDate?
}

struct FSSchedule: Codable {
    let flightType, serviceClasses, restrictions: String?
}

struct FSFlightTrackRequest: Codable {
    let flightID: FSFlightID?
    let extendedOptions: FSExtendedOptions?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case flightID = "flightId"
        case extendedOptions, url
    }
}

struct FSExtendedOptions: Codable {
}

struct FSFlightID: Codable {
    let requested: String?
    let interpreted: Int?
}

