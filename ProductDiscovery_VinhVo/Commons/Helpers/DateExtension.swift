//
//  DateExtension.swift
//  EverydayRacism
//
//  Created by Vinh Vo on 3/22/18.
//  Copyright © 2018 Vinh Vo. All rights reserved.
//

import UIKit

extension Date {

    var dayName: String {
        return self.toString(format: "EEEE")
    }

    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_En")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    func getHour() -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }

    var start: Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    var end: Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }

    func dayBetween(otherDay: Date) -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day], from: self, to: otherDay)
        return components.day ?? 0
    }

    func hoursBetween(otherDate: Date) -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: self, to: otherDate)
        return components.hour ?? 0
    }
    
    func secondsBetween(otherDate: Date) -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.second], from: self, to: otherDate)
        return components.second ?? 0
    }

    func goToDate(num : Int) -> Date {
        let newDate = Calendar.current.date(byAdding: .day, value: num, to: self)
        return newDate!

    }
    
    // or GMT time
    var UtcTime: Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSS"
        let dateString = formatter.string(for: self)
        return formatter.date(from: dateString!)!
    }
    
}

