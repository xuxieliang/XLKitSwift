//
//  NumberProtocol.swift
//  YXChainDemo
//
//  Created by zxw on 2023/11/16.
//  Copyright © 2023 yxqiche. All rights reserved.
//

import Foundation

public protocol NumberProtocol {}

extension NumberProtocol {
    var doubleValue: Double {
        if let num = self as? Int {
            return Double(num)
        }
        if let num = self as? CGFloat {
            return Double(num)
        }
        if let num = self as? Float {
            return Double(num)
        }
        if let num = self as? Double {
            return num
        }
        return 0
    }
}

extension Int: NumberProtocol {}
extension CGFloat: NumberProtocol {}
extension Float: NumberProtocol {}
extension Double: NumberProtocol {}



public protocol ToStringProtocol {
    var yx_toString: String { get }
}

public extension ToStringProtocol {
    var yx_toString: String {
        return "\(self)"
    }
}

extension Int: ToStringProtocol { }

extension Int16: ToStringProtocol { }

extension Int32: ToStringProtocol { }

extension Int64: ToStringProtocol { }

extension Float: ToStringProtocol { }

extension Double: ToStringProtocol { }

extension CGFloat: ToStringProtocol { }
