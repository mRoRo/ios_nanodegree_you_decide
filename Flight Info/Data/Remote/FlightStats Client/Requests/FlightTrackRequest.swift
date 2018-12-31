//
//  FlightTrackRequest.swift
//  Flight Info
//
//  Created by Maro on 26/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift
import RxAlamofire

final class FlightTrackRequest: FlightTrackDataSource {
    
    func getFlightTrack(id: String) -> Observable<FSFlightTrackResponse> {
        
        let parameters = RequestUtils.authParameters()
        
        // add the flight id to the method
        let method = RequestUtils.substituteKeyInMethod(FSClientConstants.Methods.FlightTrack, key: FSClientConstants.URLKeys.FlightId, value: id)!
        
        // compose the url
        let urlString = RequestUtils.urlFromParameters(parameters, withPathExtension: method)
        
        return RxAlamofire.requestData(.get, urlString)
            .mapObject(type: FSFlightTrackResponse.self)
    }
}
