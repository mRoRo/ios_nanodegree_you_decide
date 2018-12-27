//
//  StringUtils.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

class StringUtils {
    static func capitalizeFirstChar(_ originString : String)-> String{
        var components = originString.components(separatedBy: " ")
        guard let first = components.first else {
            return originString
        }
        components[0] = first.capitalized
        return components.joined(separator: " ")
    }
}
