//
//  CachedProductProvider.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import Foundation
import RealmSwift

class CachedProductProvider {
    
    //MARK: - Save
    func save(products: [Product]) {
        deleteAll()
        products.forEach { (product) in
            CachedProduct.create(product: product)?.add()
        }
    }
    
    
    //MARK: - delete
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    //MARK: - Get
    func getAllCachedProduct() -> [Product]? {
        let arr = CachedProduct.fetchAll(CachedProduct.self)
        return arr?.toArray(type: CachedProduct.self).map{ $0.createProduct() }
    }
    
    func getCachedProductBy(strSearch: String) -> [Product]? {
        guard strSearch != "" else {
            return getAllCachedProduct()
        }
        var result = [Product]()
        result += queryCaseInsensitive(strSearch: strSearch) ?? []
        result += queryCaseSensitive(strSearch: strSearch) ?? []
        return result
    }
    
    func queryCaseInsensitive(strSearch: String) -> [Product]? {
        let lowercasedStr = strSearch.lowercased()
        let query = "lowercasedName CONTAINS '\(lowercasedStr)'"
        let arr = CachedProduct.fetchAll(query: query, CachedProduct.self)
        return arr?.toArray(type: CachedProduct.self).map{ $0.createProduct() }
    }
    
    func queryCaseSensitive(strSearch: String) -> [Product]? {
        let lowercasedStr = strSearch.lowercased()
        var query = "NOT lowercasedName CONTAINS '\(lowercasedStr)'"
        let words = lowercasedStr.split(separator: " ")
        if words.count > 1 {
            words.forEach { (word) in
                query += " AND lowercasedName CONTAINS '\(word)'"
            }
        } else {
            return nil
        }
        let arr = CachedProduct.fetchAll(query: query, CachedProduct.self)
        return arr?.toArray(type: CachedProduct.self).map{ $0.createProduct() }
    }
    
    
    
    
}
