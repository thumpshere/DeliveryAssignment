//
//  StorageHelper.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 09/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import Cache
class StorageHelper: NSObject {
  static let sharedInstance = StorageHelper()
  
  let storage = try? Storage(
    diskConfig: DiskConfig(name: Constants.dataStoreId),
    memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10),
    transformer: TransformerFactory.forCodable(ofType: [DeliveryObject].self)
  )
  
  func getDataFromCache(keyString: String) -> [DeliveryObject] {
    let cachedData = (try? storage?.object(forKey: keyString)) ?? [DeliveryObject]()
    return cachedData
  }
  
  func saveDataToCache (data: [DeliveryObject], keyString: String) {
    do {
      try storage?.setObject(data, forKey: keyString)
    } catch {
      print(error)
    }
  }
  
  func deleteDataFromCache(keyString: String) {
    do {
      try storage?.removeObject(forKey: keyString)
    } catch {
      
    }
  }
}
