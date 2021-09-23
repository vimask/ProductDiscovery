//
//  NotificationHandler.swift
//  Waxii
//
//  Created by Dinh Anh huy on 7/20/17.
//  Copyright © 2017 MMSofts. All rights reserved.
//

import UIKit

public extension Int {
    var notificationHandlder: NotificationHandler? {
        return NotificationHandler(rawValue: String(self))
    }
}

public extension String {
    var notificationHandlder: NotificationHandler? {
        return NotificationHandler(rawValue: self)
    }
}

public enum NotificationHandler: String {
    
    static let center = NotificationCenter()
    
    //Handle user interaction with apple notification
    case updateData = "kUpdateData"
    case restartGame = "kRestartGame"
    
    //Push notification
    case transfer = "1"
    case purchase = "2"
    case monthEnd = "3"
    case redeem = "4"
    case firstLogin = "5"

    //MARK: Additional Helper
    var notificationName: Notification.Name {
        return Notification.Name(self.rawValue)
    }
    
    func post(userInfo: [AnyHashable: Any]? = nil, object: Any? = nil) {
        NotificationHandler.center.post(name: notificationName, object: object, userInfo: userInfo)
    }
    
    func register(observer: Any, selector: Selector, object: Any? = nil) {
        unregister(observer: observer)
        NotificationHandler.center.addObserver(observer, selector: selector, name: notificationName, object: object)
    }
    
    func unregister(observer: Any, object: Any? = nil) {
        NotificationHandler.center.removeObserver(observer, name: notificationName, object: object)
    }
    
    static func unregisterAll(observer: Any) {
        NotificationHandler.center.removeObserver(observer)
    }
}
