//
//  UIButton+Extension.swift
//  Taoyuejia
//
//  Created by AhriLiu on 2020/11/24.
//  Copyright © 2020 zxw. All rights reserved.
//

import UIKit

var expandSizeKey_W = "expandSizeKey_W"
var expandSizeKey_H = "expandSizeKey_H"

extension UIControl {
    
    /// 扩大点击区域 size: 宽高各拓宽size像素
    @objc @discardableResult open func yx_expandTapSize(size: CGFloat) -> Self {
        objc_setAssociatedObject(self, &expandSizeKey_W, size, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &expandSizeKey_H, size, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        return self
    }
    
    /// 扩大点击区域
    @objc @discardableResult open func yx_expandTap(width: CGFloat, height: CGFloat) -> Self {
        objc_setAssociatedObject(self, &expandSizeKey_W, width, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &expandSizeKey_H, height, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        return self
    }
    
    /// 当前
    @objc open func yx_getExpandRect() -> CGRect {
        let expandSize_W = objc_getAssociatedObject(self, &expandSizeKey_W) as? CGFloat ?? 0
        let expandSize_H = objc_getAssociatedObject(self, &expandSizeKey_H) as? CGFloat ?? 0
        if (expandSize_W > 0 || expandSize_H > 0) {
            return CGRect(x: bounds.origin.x - (expandSize_W), y: bounds.origin.y - (expandSize_H), width: bounds.size.width + 2 * (expandSize_W), height: bounds.size.height + 2 * (expandSize_H))
        } else {
            return bounds;
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRect = yx_getExpandRect()
        if (buttonRect.equalTo(bounds)) {
            return super.point(inside: point, with: event)
        } else {
            return buttonRect.contains(point)
        }
    }
    
}
 
