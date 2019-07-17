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
   func fetchDeliveries (offset: Int, limit: Int, success successBlock: @escaping (([ListObject]) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void))
}

class ApiManager: APIManagerProtocol {
  
  func fetchDeliveries (offset: Int, limit: Int, success successBlock: @escaping (([ListObject]) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
    if !AssignmentHelper.isConnectedToInternet() {
      return failureBlock(LocalizedKeys.noInternet as AnyObject)
    }
    let requestURL = "\(PathURLs.deliveriesUrl)offset=\(offset)&limit=\(limit)"
    let decoder = JSONDecoder()
    AF.request(requestURL).responseData { response in
      // response serialization result
      if let data = response.data {
        do {
          let dataArray = try decoder.decode([ListObject].self, from: data)
          successBlock(dataArray)
        } catch let err {
          print(err)
          failureBlock(err.localizedDescription as AnyObject)
        }
      } else {
        failureBlock(response.error as AnyObject)
      }
    }
  }
  
}
