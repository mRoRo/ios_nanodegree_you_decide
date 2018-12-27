//
//  RequestUtils.swift
//  Flight Info
//
//  Created by Maro on 26/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import Foundation

class RequestUtils {
    
    // MARK: URL
    static func urlFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = FSClientConstants.Constants.APIScheme
        components.host = FSClientConstants.Constants.APIHost
        components.path =
            FSClientConstants.Constants.APIPath +
            FSClientConstants.Constants.APIProtocol +
            FSClientConstants.Constants.APIVersion +
            FSClientConstants.Constants.APIFormat +
            (withPathExtension ?? "")
        
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    // MARK: Method
    // substitute the key for the value that is contained within the method name
    static func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    // MARK: Parameters
    static func authParameters() -> [String:AnyObject] {
        return [FSClientConstants.ParameterKeys.AppId: FSClientConstants.ParameterValues.AppId as AnyObject,
                FSClientConstants.ParameterKeys.AppKey: FSClientConstants.ParameterValues.AppKey as AnyObject]
    }
}

