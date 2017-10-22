//
//  UIViewControllerExtensions.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // function that shows a default alert
    func showDefaultAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message : message, preferredStyle : .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    // function that shows a custom alert
    func showCustomAlert(title: String? = nil, message: String? = nil, style: UIAlertControllerStyle, actions: [(String, UIAlertActionStyle, ((UIAlertAction) -> Void)?)], alertCompletion : (() -> Void)? = nil){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for elements in actions {
            let action = UIAlertAction(title: elements.0, style: elements.1, handler: elements.2)
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: alertCompletion)
    }
    
}

