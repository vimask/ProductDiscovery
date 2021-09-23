//
//  Product.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import Foundation
import Networking

struct Product: Codable {

    var id: Int?
    var name: String?
    var imageUrl: String?
    var dateAdded: String?
    var dateUpdated: String?
    var price: Double?
    var brand: String?
    var code: String?

}

extension Product: NetworkingJSONDecodable {}
