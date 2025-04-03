//
//  Collection+Extension.swift
//  Taoyuejia
//
//  Created by zxw on 2020/11/4.
//  Copyright © 2020 zxw. All rights reserved.
//

import UIKit

extension Collection {
    
    
    /// 按 拼音首字符处理数据
    ///
    ///  原数据： [Model]
    /// 返回示例：
    /// [
    ///     "A": [Model],
    ///     "B": [Model]
    /// ]
    /// - Parameter by: by description
    /// - Returns: description
    public func yx_handleByPinYinFirstLetter(_ by: (Self.Element) -> String) -> [String: [Self.Element]] {
        
        var result = [String: [Self.Element]]()
        for element in self {
            let key = by(element)
            let firstLetter = key.yx_getPinyinUpperHead()
            var arr = result[firstLetter] ?? [Self.Element]()
            arr.append(element)
            result[firstLetter] = arr
        }
        return result
    }
    
    /// 按 Model某个 字段名 处理数据
    /// 原数据： [Model]
    /// 返回示例：
    /// [
    ///     "type1": [Model],
    ///     "type1": [Model]
    /// ]
    /// - Parameter by: by description
    /// - Returns: description
    public func yx_handleByTypeName(_ by: (Self.Element) -> String) -> [String: [Self.Element]] {
        
        var result = [String: [Self.Element]]()
        for element in self {
            let key = by(element)
            var arr = result[key] ?? [Self.Element]()
            arr.append(element)
            result[key] = arr
        }
        return result
    }
    
    /// 转换JSONString
    public func yx_jsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to string: \(error.localizedDescription)")
        }
        return nil
    }
}
