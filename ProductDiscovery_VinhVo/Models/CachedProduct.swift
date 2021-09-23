//
//  CachedProduct.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import Foundation

import RealmSwift

class CachedProduct: Object {
    
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    @objc dynamic var lowercasedName : String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var dateAdded : String?
    @objc dynamic var dateUpdated : String?
    @objc dynamic var price : Double = 0
    @objc dynamic var brand : String?
    @objc dynamic var code : String?
 
    static func create(product: Product?) -> CachedProduct? {
        guard let product = product else { return nil }
        let cachedProduct = CachedProduct()
        cachedProduct.id = product.id ?? 0
        cachedProduct.name = product.name
        cachedProduct.imageUrl = product.imageUrl
        cachedProduct.dateAdded = product.dateAdded
        cachedProduct.dateUpdated = product.dateUpdated
        cachedProduct.price = product.price ?? 0
        cachedProduct.brand = product.brand
        cachedProduct.code = product.code
        cachedProduct.lowercasedName = (product.name?.lowercased() ?? "") + " " + (product.code?.lowercased() ?? "")
        return cachedProduct
    }
    
    func createProduct() -> Product {
        var product = Product()
        product.id = self.id
        product.name = self.name
        product.imageUrl = self.imageUrl
        product.dateAdded = self.dateAdded
        product.dateUpdated = self.dateUpdated
        product.price = self.price
        product.brand = self.brand
        product.code = self.code
        return product
    }

    
}
