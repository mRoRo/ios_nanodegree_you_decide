//
//  ObservableType+Map.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            let responseTuple = data as? (HTTPURLResponse, Data)
            
            // check if server response is [200 - 299]
            if let statusCode = responseTuple?.0.statusCode {
                if (statusCode < 200 || statusCode > 299) {
                    throw NSError(
                        domain: "FlightStats",
                        code: statusCode,
                        userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("server_error", comment: "server error")]
                    )
                }
            }
            
            // check if data can be decoded...
            guard let jsonData = responseTuple?.1 else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("server_error", comment: "server error")]
                )
            }
            
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: jsonData)
            
            print(object)
            return Observable.just(object)
        }
    }
}

