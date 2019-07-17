//
//  ListLocation.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import Foundation

struct DeliveryLocation: Codable {
  
  let address: String?
  let lat: Double?
  let lng: Double?
  
  enum CodingKeys: String, CodingKey {
    case address = "address"
    case lat = "lat"
    case lng = "lng"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    address = try values.decodeIfPresent(String.self, forKey: .address)
    lat = try values.decodeIfPresent(Double.self, forKey: .lat)
    lng = try values.decodeIfPresent(Double.self, forKey: .lng)
  }
}
