//
//  constants.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 06/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
  static let emptyCachedDataNotificationKey = "emptyCachedData"
  static let cachedObjectKey = "CachedObject"
  static let testObjectKey = "testCachedObject"
  static let dataStoreId =  "apiData"
  static let dataEmptyFromServer =  "emptyDataFromServer"
  
}

struct ScreenDimensions {
  static let screenWidth = UIScreen.main.bounds.width
  static let screenHeight = UIScreen.main.bounds.height
}

struct ParameterKeys {
  static let keyOffset = "offset"
  static let keyLimit = "limit"
  static let keyAmpersand = "&"
}

struct BaseURLs {
  static let testUrl = "https://mock-api-mobile.dev.lalamove.com/"
}

struct PathURLs {
  static let deliveriesUrl = "deliveries?"
}

struct CellIdentifiers {
  static let deliveryListCell = "deliveryCell"
}

struct CellViewConstants {
  static let imageCornerRadius: CGFloat = 40.0
  static let cellBorderWidth: CGFloat = 2.0
  static let labelFontSize: CGFloat = 20.0
}
