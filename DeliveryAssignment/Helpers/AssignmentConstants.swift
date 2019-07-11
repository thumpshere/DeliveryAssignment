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

struct PathURLs {
  static let deliveriesUrl = "https://mock-api-mobile.dev.lalamove.com/deliveries?"
}

struct CellIdentifiers {
  static let deliveryListCell = "deliveryCell"
}

struct CellViewConstants {
  static let imageCornerRadius: CGFloat = 40.0
  static let cellBorderWidth: CGFloat = 2.0
  static let labelFontSize: CGFloat = 20.0
  
}

struct StringIdentifiers {
  static let noInternet = "NOInternet".localized
  static let errorHeading = "Attention".localized
  static let errorRefreshingData = "errorRefreshData".localized
  static let messageHeading = "Message".localized
  static let deliveryListTitle = "DeliveryListTitle".localized
  static let refreshDataMessage = "refreshControl.text".localized
  static let deliveryDetailTitle = "DeliveryDetailsTitle".localized
  static let alertButtonTitleOK = "OK".localized
  
}

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
}
