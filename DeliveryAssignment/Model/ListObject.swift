//
//  ListRootClass.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import Foundation

struct ListObject: Codable {
    
    let descriptionField: String?
    let itemId: Int?
    let imageUrl: String?
    let location: ListLocation?
    
    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case itemId = "id"
        case imageUrl = "imageUrl"
        case location = "location"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        itemId = try values.decodeIfPresent(Int.self, forKey: .itemId)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
       location = try values.decodeIfPresent(ListLocation.self, forKey: .location)
    }
    
}
