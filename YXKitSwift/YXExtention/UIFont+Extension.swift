// 
//  UIFont+Extension.swift
//  YXKitSwift
//
//  Created by zxw on 2023/12/29.
//

import UIKit

public extension UIFont {
    
    static func yx_font(_ fontSize: CGFloat, _ weight: Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
    static func yx_system(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    static func yx_bold(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    static func yx_medium(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    static func yx_semibold(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
}
