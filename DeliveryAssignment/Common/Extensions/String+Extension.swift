//
//  String+Extension.swift
//  DeliveryAssignment
//
//  Created by Arpit Tripathi on 12/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
}
