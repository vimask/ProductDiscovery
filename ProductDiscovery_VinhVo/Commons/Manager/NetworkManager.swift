//
//  NetworkManager.swift
//  binumi-ios
//
//  Created by Vinh Vo on 8/8/17.
//  Copyright © 2017 Vinh Vo. All rights reserved.
//

import UIKit
import ReachabilitySwift

@objc protocol NetworkManagerDelegate:NSObjectProtocol {
    func slowNetworkCalledBack()
    func stableNetworkCalledBack()
    func reconnectNetworkCalledBack()

}

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    
    weak var delegate:NetworkManagerDelegate?
    var reach: Reachability?
    var lastStatus = true
    
    func testSpeed() {
        
        do {
            let startTime = Date()
            self.reach = Reachability(hostname: "http://www.google.com")
            self.reach!.whenReachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                
                let endTime = NSDate()
                let result = endTime.timeIntervalSince(startTime)
                if self.delegate != nil {
                    if result >= 0.5{
                        self.delegate?.slowNetworkCalledBack()
                    } else {
                        self.delegate?.stableNetworkCalledBack()
                    }
                }
                
                if self.lastStatus == false {
                    DispatchQueue.main.async() {
                        self.delegate?.reconnectNetworkCalledBack()
                    }
                }
                self.lastStatus = true
                
                self.reach?.stopNotifier()
                
            }
            
            self.reach!.whenUnreachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                DispatchQueue.main.async() {
//                    log?.info("Not reachable")
                }
                
                self.reach?.stopNotifier()
                self.lastStatus = false
            }
            try! self.reach?.startNotifier()
            
        }
        
    }
    
}
