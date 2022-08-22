//
//  Utility.swift
//  MapKitDemo
//
//  Created by PC on 17/08/22.
//

import Foundation
import CoreLocation
import UIKit

class Utility {
    
    // MARK: - Variables
    static let shared = Utility()

    
    class func showAlertForAppSettings(title: String, message: String, allowCancel: Bool = true, completion: @escaping (Bool) -> ()) {
        
        let alertController: UIAlertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default, handler: { (action) -> Void in
            
            let settingURL = URL(string: UIApplication.openSettingsURLString)!
            
            if(UIApplication.shared.canOpenURL(settingURL)) {
                UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
            }
            
            completion(false)
            
        }))
        
        if allowCancel {
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (action) -> Void in
                
                completion(false)
                
            }))
        }
        
        UIApplication.rootViewController()?.present(alertController, animated: true, completion: nil)
    }
    
}
