//
//  AssignmentHelper.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit

class AssignmentHelper: NSObject {
  static let sharedInstance = AssignmentHelper()
  
  override init() {}

  func showAlert (title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    // add an action (button)
    alert.addAction(UIAlertAction(title: StringIdentifiers.alertButtonTitleOK, style: UIAlertAction.Style.default, handler: nil))
    guard let window = UIApplication.shared.keyWindow else { return }
    // show the alert
    window.rootViewController?.present(alert, animated: true, completion: nil)
  }

}
