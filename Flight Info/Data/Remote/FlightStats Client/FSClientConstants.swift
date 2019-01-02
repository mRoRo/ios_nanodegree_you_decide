//
//  FSClientConstants.swift
//  Flight Info
//
//  Created by Maro on 25/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//
import Foundation

class FSClientConstants {
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "api.flightstats.com"
        static let APIPath = "/flex/flightstatus"
        static let APIProtocol = "/rest"
        static let APIVersion = "/v2"
        static let APIFormat = "/json"
    }
    
    // MARK: Methods
    struct Methods {
        static let FlightsNear = "/flightsNear/{lat}/{lon}/{miles}"
        static let FlightTrack = "/flight/status/{flightId}"
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let Lat = "lat"
        static let Lon = "lon"
        static let Miles = "miles"
        static let FlightId = "flightId"
    }
    
    // MARK: Flight Status Parameter Keys
    struct ParameterKeys {
        static let AppId = "appId"
        static let AppKey = "appKey"
    }
    
    // MARK: Flight Status Parameter Values ->> ADD YOUR VALUES
    struct ParameterValues {
        static let AppId = ""
        static let AppKey = ""
    }
}
