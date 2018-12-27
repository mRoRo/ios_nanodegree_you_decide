//
//  ActivityIndicator.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import UIKit

public protocol ActivityIndicatorPresenter {
    
    /// The activity indicator
    var activityIndicator: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.color = UIColor.udacityBlue
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
