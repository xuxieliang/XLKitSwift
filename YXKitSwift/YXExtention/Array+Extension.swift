//
//  Array+Extension.swift
//  YXKitSwift
//
//  Created by zxw on 2022/6/17.
//

import UIKit

public extension Array {
    
    /// 截取子数组
    /// - Parameter form: 从某一下标开始，包含此下标数据
    /// - Returns: 子数组
    func yx_sub(form: Int) -> [Self.Element] {
        guard form < count else { return [] }
        let rang = self.index(startIndex, offsetBy: form)..<self.endIndex
        return Array(self[rang])
    }
    
    /// 截取子数组
    /// - Parameter predicate: 找到的第一个满足条件的下标元素开始；如果均不满足条件，返回空数组
    /// - Returns: 子数组
    func yx_sub(form predicate: (Self.Element) -> Bool) -> [Self.Element] {
        guard let index = self.firstIndex(where: predicate) else { return [] }
        let rang = index..<self.endIndex
        return Array(self[rang])

    }
    
    /// 从起始位置开始截取子数组
    /// - Parameter to: 截止下标，不包含此下标的元素
    /// - Returns: 子数组
    func yx_sub(to: Int) -> [Self.Element] {
        guard to < count else { return self }
        let rang = self.startIndex..<self.index(startIndex, offsetBy: to)
        return Array(self[rang])
    }
    
    /// 从起始位置开始截取子数组,
    /// - Parameter predicate: 截止到第一个满足终止条件的元素，不包含此元素; 如果均不满足条件，返回全部
    /// - Returns: 子数组
    func yx_sub(to predicate: (Self.Element) -> Bool) -> [Self.Element] {
        guard let index = self.firstIndex(where: predicate) else { return self }
        let rang = self.startIndex..<index
        return Array(self[rang])
    }
    
    /// 截取某一范围的子数组
    /// - Parameters:
    ///   - location: 下标
    ///   - length: 长度
    /// - Returns: 子数组
    func yx_sub(location:Int, length:Int) -> [Self.Element] {
        guard location < count else { return [] }
        guard location + length < count else { return yx_sub(form: location) }
        let locationIndex = self.index(startIndex, offsetBy: location)
        let rang = locationIndex..<self.index(locationIndex, offsetBy: length)
        return Array(self[rang])
    }
}
