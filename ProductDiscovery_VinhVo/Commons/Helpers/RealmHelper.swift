//
//  RealmFetch.swift
//  Waxii
//
//  Created by Vinh Vo on 7/19/17.
//  Copyright © 2017 Vinh Vos. All rights reserved.
//

import UIKit
import RealmSwift

typealias UpdateRealmBlock = (_ realm: Realm) -> ()

extension Realm {
    static func write(updateBlock: UpdateRealmBlock) {
        Realm.block { (realm) in
            do {
                try realm.write { updateBlock(realm) }
            } catch { Debug.print("Cant write with realm", error) }
        }
    }
    
    static func block(updateBlock: UpdateRealmBlock) {
        do {
            let realm = try Realm()
            updateBlock(realm)
        } catch { Debug.print("Cant init realm object", error) }
    }
}

extension Object {
    static func fetchAll<ObjectType: Object>(query: String? = nil, _ type: ObjectType.Type) -> Results<ObjectType>? {
        var result: Results<ObjectType>?
        Realm.block { (realm) in
            let inspection = (query != nil ? realm.objects(type).filter(NSPredicate(format: query!)) : realm.objects(type))
            result = inspection
        }
        return result
    }
    
    func add() {
        Realm.write { realm in
            realm.add(self)
        }
    }

    func delete() {
        Realm.write { (realm) in
            realm.delete(self)
        }
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
