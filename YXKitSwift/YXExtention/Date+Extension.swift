//
//  Date+Extension.swift
//  Taoyuejia
//
//  Created by zxw on 2020/10/24.
//  Copyright © 2020 zxw. All rights reserved.
//

import UIKit

public extension Date {
    
    /// 将 相应格式的时间字符串 转换成时间
    /// - Parameters:
    ///   - string: 时间字符串
    ///   - format: 时间字符串格式
    static func yx_date(from string: String, format: String) -> Date? {
        return string.yx_date(format)
    }
    
    /// 将时间 转换成目标格式的字符串
    /// - Parameter format: 目标时间字符串
    func yx_string(_ format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: self)
    }
    
    /// 大于， self > date 时返回true
    /// - Parameter date: 比较值
    func yx_isGreater(than date: Date?) -> Bool? {
        guard let date = date else { return nil }
        return self > date
    }
    
    /// 小于， self < date 时返回true
    /// - Parameter date: 比较值
    func yx_isLess(than date: Date?) -> Bool? {
        guard let date = date else { return nil }
        
        return self < date
    }
    
    
    /// 获取date当天的起始时间；示例：2021-10-26 19:30:26  -> 2021-10-26 00:00:00
    func yx_getDayStart() -> Date {
        return yx_string("yyyy-MM-dd")?.yx_date("yyyy-MM-dd") ?? self
    }
    
    /// 获取date当天的结束时间；示例：2021-10-26 19:30:26  -> 2021-10-26 23:59:59
    func yx_getDayEnd() -> Date {
        return yx_string("yyyy-MM-dd")?.appending(" 23:59:59").yx_date("yyyy-MM-dd HH:mm:ss") ?? self
    }
    
    /// 默认星期几，preString传“周” 为周几
    func yx_getWeek(preString: String? = nil) -> String {
        let weakDay = Calendar.current.component(.weekday, from: self)
        let array = ["", "日", "一", "二", "三", "四", "五", "六"]
        return "\(preString ?? "星期")\(array[weakDay])"
    }
}
