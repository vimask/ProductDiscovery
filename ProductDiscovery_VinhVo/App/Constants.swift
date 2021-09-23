//
//  Constants.swift
//
//
//  Created by vxvinh on 5/26/21.
//  Copyright © 2021 Vinh Vo. All rights reserved.
//

import UIKit

struct Config {
    static let baseURL = "https://run.mocky.io/v3"
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let snativeHeight = UIScreen.main.nativeBounds.height
    static let separateHeight = 1.0 / UIScreen.main.scale
}

struct Constants {
    static var safePadding: CGFloat {
        return (Config.snativeHeight == 2436 || Config.snativeHeight == 2778) ? 22 : 0
    }
    
    static let maxRedeemHours: Int = 24
    static let demoAccount = "999999999"
}


//MARK: - Colors
struct Colors {
    static let blue         = #colorLiteral(red: 0.188349992, green: 0.1137254902, blue: 0.9098039216, alpha: 1)
    static let tomato       = #colorLiteral(red: 0.9226083755, green: 0.2097787857, blue: 0.120218955, alpha: 1)
    static let gray         = #colorLiteral(red: 0.9320248961, green: 0.945730269, blue: 0.9526857734, alpha: 1)
    static let yellow       = #colorLiteral(red: 0.9294004878, green: 0.9686274529, blue: 0.06786105815, alpha: 1)
}


//MARK: - Fonts
struct FontFamily {
    static let regular      = "HelveticaNeue"
    static let bold         = "HelveticaNeue-Bold"
    static let black        = "HelveticaNeue-CondensedBold"
    static let medium       = "HelveticaNeue-Medium"
    static let light        = "HelveticaNeue-Light"
    static let lightItalic  = "HelveticaNeue-LightItalic"
    static let mediumItalic = "HelveticaNeue-MediumItalic"
    static let boldItalic   = "HelveticaNeue-BoldItalic"
}

struct Fonts {
    static let textBold      = UIFont(name: FontFamily.bold, size: 14)
    static let textMedium    = UIFont(name: FontFamily.medium, size: 14)
    static let textRegular   = UIFont(name: FontFamily.regular, size: 14)
    static let textLight     = UIFont(name: FontFamily.light, size: 14)
    static let header        = UIFont(name: FontFamily.bold, size: 16)
    static let headerItalic  = UIFont(name: FontFamily.boldItalic, size: 16)
    static let eventHeader   = UIFont(name: FontFamily.bold, size: 12)
}


//MARK: - Keys
struct Keys {
    //MARK: app
    static let moneyFormat  = "en_US"
    static let kEmail       = "email"
    static let kName        = "name"
    static let kToken       = "token"
    static let kPassword    = "password"
    static let kUserID      = "user_id"
}

