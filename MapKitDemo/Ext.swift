//
//  Ext.swift
//  MapKitDemo
//
//  Created by PC on 17/08/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(message: String, title: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIApplication {
    
    static func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        var topController: UIViewController? = keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
     class func rootViewController() -> UIViewController? {
         return UIApplication.shared.connectedScenes
                 .filter({$0.activationState == .foregroundActive})
                 .compactMap({$0 as? UIWindowScene})
                 .first?.windows
                 .filter({$0.isKeyWindow}).first?.rootViewController
     }
}



