//
//  AlertPresenter.swift
//  Flight Info
//
//  Created by Maro on 27/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import UIKit

protocol AlertPresenter {}

extension AlertPresenter where Self: UIViewController {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
            title: NSLocalizedString("ok", comment: "ok").uppercased(),
            style: .default,
            handler: nil))
        present(alertController, animated: true, completion: nil)
        alertController.view.tintColor = .red
    }
}
