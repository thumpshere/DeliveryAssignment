//
//  ApiManager.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 04/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import Alamofire

protocol APIManagerProtocol {
   func getDataToBeShownIntoList (offset: Int, limit: Int, success successBlock: @escaping (([ListObject]) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void))
}

class ApiManager: APIManagerProtocol {
  
  static let sharedInstance = ApiManager()
  
  func getDataToBeShownIntoList (offset: Int, limit: Int, success successBlock: @escaping (([ListObject]) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
    if !self.isConnectedToInternet() {
      AssignmentHelper.sharedInstance.showAlert(title: StringIdentifiers.errorHeading, message: StringIdentifiers.noInternet)
      return failureBlock("not reachable" as AnyObject)
    }
    let urlRequest = "\(PathURLs.deliveriesUrl)offset=\(offset)&limit=\(limit)"
    AF.request(urlRequest).responseData { response in
      // response serialization result
      if let data = response.data {
        do {
          let decoder = JSONDecoder()
          let dataArray = try decoder.decode([ListObject].self, from: data)
          successBlock(dataArray)
        } catch let err {
          print(err)
          let dataArray = [ListObject]()
          successBlock(dataArray)
        }
      } else {
        failureBlock(response.error as AnyObject)
      }
    }
  }
  
  func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
  }
}
