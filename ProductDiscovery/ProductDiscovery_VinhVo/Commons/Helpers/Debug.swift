//
//  Debug.swift
//
//
//  Created by Vinh Vo on 6/30/17.
//  Copyright © 2017 Vinh Vos. All rights reserved.
//

import Foundation
//import SwiftyJSON

class Debug {

    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
        #endif
    }

    ///vxv: print cURL, so you can copy and run on terminal
//    static func printCurl(httpMethod:String, url:String, token:String, body:[String:Any?]? = nil){
//        #if DEBUG
//        Swift.print("\n------------")
//        Swift.print("curl -X \(httpMethod) \\")
//        Swift.print("\(url) \\")
//        Swift.print(" -H 'content-type: application/json' \\")
//        Swift.print(" -H 'token: \(token)' \\")
//        if let body = body {
//            let json = JSON(body)
//            Swift.print(" -d '\(json.rawString([.castNilToNSNull: true]) ?? "")' \\")
//        }
//        Swift.print(" | python -m json.tool")
//        Swift.print("------------\n")
//        #endif
//    }

}
