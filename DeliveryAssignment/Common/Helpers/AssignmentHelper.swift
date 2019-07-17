//
//  AssignmentHelper.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import Alamofire

class AssignmentHelper: NSObject {
  
  class func showAlert (title: String, message: String, success successBlock: @escaping (() -> Void)) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    // add an action (button)
    alert.addAction(UIAlertAction(title: LocalizedKeys.alertButtonTitleOK, style: UIAlertAction.Style.default, handler: nil))
    guard let window = UIApplication.shared.keyWindow else { return }
    // show the alert
    window.rootViewController?.present(alert, animated: true, completion: {
      successBlock()
    })
  }

class func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
  }
  
}
