//
//  YXLilineSwift2.swift
//  YXKitSwift
//
//  Created by zx on 2021/4/12.
//

import Foundation
import UIKit

/// 关闭键盘
public func YX_EndEditing() {
    UIApplication.shared.keyWindow?.endEditing(true)
}

/// GCD定时器倒计时
///
/// - Parameters:
///   - timeInterval: 间隔时间
///   - repeatCount: 重复次数
///   - handler: 循环事件,闭包参数: 1.timer 2.剩余执行次数
public func YX_DispatchTimer(timeInterval: Double, repeatCount: Int, handler: @escaping (DispatchSourceTimer?, Int) -> Void) -> DispatchSourceTimer? {
    if repeatCount <= 0 {
        return nil
    }
    
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var count = repeatCount
    timer.schedule(deadline: .now(), repeating: timeInterval)
    timer.setEventHandler {
        count -= 1
        DispatchQueue.main.async {
            handler(timer, count)
        }
        if count == 0 {
            timer.cancel()
        }
    }
    timer.resume()
    
    return timer
}

/// 设置默认值，当初始值为nil, 或字符串为 ""时，返回 defaultValue，否则返回 initialValue
/// - Parameters:
///   - initialValue: 初始值
///   - defaultValue: 为空值时，设置的默认值
/// - Returns: <T>
public func YX_SetDefault<T>(_ initialValue: T?, _ defaultValue: T) -> T {
    guard let initialValue = initialValue else {
        return defaultValue
    }
    if let initial = initialValue as? String, initial.isEmpty {
        return defaultValue
    }
    return initialValue
}

/// 判断对象是否为空，支持 字符串、数组、字典
/// - Parameter value: value description
/// - Returns: 是否为空
public func YX_IsEmpty<T>(_ value: T?) -> Bool {
    // 为nil时
    guard let value = value else {
        return true
    }
    // 为字符串且长度为0时
    if let string = value as? String, string.isEmpty {
        return true
    }
    // 为数组且长度为0时
    if let array = value as? [Any], array.isEmpty {
        return true
    }
    // 为Set且长度为0时
    if let set = value as? Set<AnyHashable>, set.isEmpty {
        return true
    }
    // 为字典且键值对为0时
    if let dic = value as? [AnyHashable: Any], dic.isEmpty {
        return true
    }
    return false
}

/// 判断对象是否为非空，支持 字符串、数组、字典
/// - Parameter value: value description
/// - Returns: 是否为空
public func YX_IsNotEmpty<T>(_ value: T?) -> Bool {
    return !YX_IsEmpty(value)
}

/// 判断对象是否为非空，支持 字符串、数组、字典
/// - Parameter value: value description
/// - Returns: 是否为空
public func YX_hasValue<T>(_ value: T?) -> Bool {
    return !YX_IsEmpty(value)
}

/// 值比较，取较大值，支持 Int、Double、Float、String 类型
/// - Parameters:
///   - first: 第一个值
///   - second: 第二个值
/// - Returns: 返回较大的值
public func YX_Max<T>(_ first: T, _ second: T) -> T {
    if let firstInt = first as? Int, let secondInt = second as? Int {
        return firstInt > secondInt ? first : second
    }
    if let firstDouble = first as? Double, let secondDouble = second as? Double {
        return firstDouble > secondDouble ? first : second
    }
    if let firstFloat = first as? Float, let secondFloat = second as? Float {
        return firstFloat > secondFloat ? first : second
    }
    if let firstCGFloat = first as? CGFloat, let secondCGFloat = second as? CGFloat {
        return firstCGFloat > secondCGFloat ? first : second
    }
    if let firstString = first as? String, let secondString = second as? String {
        return firstString > secondString ? first : second
    }
    fatalError("暂不支持的类型比较")
}

/// 值比较，取较小值，支持 Int、Double、Float、String 类型
/// - Parameters:
///   - first: 第一个值
///   - second: 第二个值
/// - Returns: 返回较小的值
public func YX_Min<T>(_ first: T, _ second: T) -> T {
    if let firstInt = first as? Int, let secondInt = second as? Int {
        return firstInt > secondInt ? second : first
    }
    if let firstDouble = first as? Double, let secondDouble = second as? Double {
        return firstDouble > secondDouble ? second : first
    }
    if let firstFloat = first as? Float, let secondFloat = second as? Float {
        return firstFloat > secondFloat ? second : first
    }
    if let firstCGFloat = first as? CGFloat, let secondCGFloat = second as? CGFloat {
        return firstCGFloat > secondCGFloat ? second : first
    }
    if let firstString = first as? String, let secondString = second as? String {
        return firstString > secondString ? second : first
    }
    fatalError("暂不支持的类型比较")
}

/// 获取对象个数
public func YX_Count<T>(_ value: T?) -> Int {
    // 为nil时
    guard let value = value else {
        return 0
    }
    
    // 为字符串且长度为0时
    if let string = value as? String {
        return string.count
    }
    // 为数组且长度为0时
    if let array = value as? [Any] {
        return array.count
    }
    // 为Set且长度为0时
    if let set = value as? Set<AnyHashable> {
        return set.count
    }
    // 为字典且键值对为0时
    if let dic = value as? [AnyHashable: Any] {
        return dic.count
    }
    return 0
}
