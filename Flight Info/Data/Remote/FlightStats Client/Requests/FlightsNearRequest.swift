//
//  FlightsNearRequest.swift
//  Flight Info
//
//  Created by Maro on 26/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift
import RxAlamofire

final class FlightsNearRequest: FlightsNearDataSource {
    let maxMilesRadius = 200
    
    func getFlightsNear(lat: Double, lon: Double) -> Observable<FSNearFlightsResponse> {
        
        let parameters = RequestUtils.authParameters()
        
        let latString = String(lat)
        let lonString = String(lon)
        let milesString = String(maxMilesRadius)
        
        // add lat to the method
        var method = RequestUtils.substituteKeyInMethod(FSClientConstants.Methods.FlightsNear, key: FSClientConstants.URLKeys.Lat, value: latString)!
        
        // add lon to the method
        method = RequestUtils.substituteKeyInMethod(method, key: FSClientConstants.URLKeys.Lon, value: lonString)!
        
        // add miles to the method
        method = RequestUtils.substituteKeyInMethod(method, key: FSClientConstants.URLKeys.Miles, value: milesString)!
        
        // compose the url
        let urlString = RequestUtils.urlFromParameters(parameters, withPathExtension: method)
        
        return RxAlamofire.requestData(.get, urlString)
            .mapObject(type: FSNearFlightsResponse.self)
    }
}
