//
//  StringsAppearance.swift
//  Flight Info
//
//  Created by Maro on 04/01/2019.
//  Copyright © 2019 Maria Rodriguez. All rights reserved.
//
import Foundation
import UIKit

extension String {
    static let labelFontSize: CGFloat = 17.0
    
    static func getUdacityAttributedString(title: String, value: String) -> NSMutableAttributedString {
        let joinedString = String(format: "%@: %@", title, value)
        let mutableString = NSMutableAttributedString(string: joinedString, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: labelFontSize)])
        mutableString.addAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.udacityBlue,
             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: labelFontSize)
             ], range: NSRange(location:0,length:title.count+1)
        )
        return mutableString
    }
}
