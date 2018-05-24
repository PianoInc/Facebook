//
//  Extenstion.swift
//  Facebook
//
//  Created by JangDoRi on 2018. 5. 23..
//  Copyright © 2018년 piano. All rights reserved.
//

extension String {
    
    /// 해당 string과 동일한 id의 LocalizedString을 반환한다.
    var loc: String {
        guard let bundle = Bundle(identifier: "com.piano.Facebook") else {return ""}
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: self, comment: self)
    }
    
    /**
     뒤에서부터 찾고자 하는 string의 index를 반환한다.
     - parameter lastOf : 찾고자 하는 string.
     - returns : 찾고자 하는 string의 index값.
     */
    func index(lastOf: String) -> String.Index {
        if let range = range(of: lastOf, options: .backwards, range: nil, locale: nil) {
            return range.upperBound
        } else {
            return startIndex
        }
    }
}

public extension Date {
    
    /**
     규칙에 따르는 string을 반환한다.
     
     오늘, 어제, 최근 일주일, 최근 한달, %d개월 전, %d년 %d월
     */
    var group: String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        
        var todayComponents = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
        todayComponents.hour = 0
        todayComponents.minute = 0
        let today = calendar.date(from: todayComponents)!
        
        let interval = calendar.dateComponents([.year, .month, .day, .hour], from: self, to: today)
        if interval.year! > 0 {
            return String(format: "yearPast".loc, components.year!, components.month!)
        } else if interval.month! > 0 {
            return String(format: "inYear".loc, interval.month!)
        } else if interval.day! > 6 {
            return "recentMonth".loc
        } else if interval.day! > 0 {
            return "recentWeek".loc
        } else if interval.hour! > 0 {
            return "yesterday".loc
        } else {
            return "today".loc
        }
    }
    
}

