//
//  UIColor+YXSwiftAdd.swift
//  YXKitSwift
//
//  Created by zx on 2021/11/25.
//

import UIKit

public extension UIColor {
    
    /// 随机颜色
    static func yx_random() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init(_ hex: Int, _ alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hex & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    convenience init?(_ hexString: String?, _ alpha: CGFloat = 1.0) {
        
        guard var formattedHex = hexString else { return nil }
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        guard formattedHex.count == 6 else { return nil }
        
        var hexValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&hexValue)
        
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat = 1.0) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}
