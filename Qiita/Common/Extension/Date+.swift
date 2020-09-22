//
//  Date+.swift
//  Qiita
//
//  Created by kntk on 2019/09/30.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

extension Date {

    func offsetFrom() -> String {
        if yearsFrom()   > 0 { return "\(yearsFrom()) years ago"   }
        if monthsFrom()  > 0 { return "\(monthsFrom()) month ago"  }
        if weeksFrom()   > 0 { return "\(weeksFrom()) weeks ago"   }
        if daysFrom()    > 0 { return "\(daysFrom()) days ago"    }
        if hoursFrom()   > 0 { return "\(hoursFrom()) hours ago"   }
        if minutesFrom() > 0 { return "\(minutesFrom()) minutes ago" }
        if secondsFrom() > 0 { return "\(secondsFrom()) seconds ago" }
        return ""
    }

    func yearsFrom() -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
    }
    func monthsFrom() -> Int {
        return Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0
    }
    func weeksFrom() -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
    }
    func daysFrom() -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
    }
    func hoursFrom() -> Int {
        return Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
    }
    func minutesFrom() -> Int {
        return Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
    }
    func secondsFrom() -> Int {
        return Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
    }

}
