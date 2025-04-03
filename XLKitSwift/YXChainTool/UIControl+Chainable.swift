//
//  UIResponder+Chainable.swift
//  YXKitSwift
//
//  Created by zhuxuewei on 2018/5/28.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit

private struct YXControlAssociatedKeys {
    static var warpperKey = "kWarpperKey"
}

public extension ViewChainable where Self: UIControl {

    @discardableResult func addAction(_ controlEvents: UIControl.Event, ignoreEventTime: Double = 0, action: @escaping (UIControl) -> ()) -> Self {
        
        self.removeAction(for: controlEvents)
        var warppers = objc_getAssociatedObject(self, &YXControlAssociatedKeys.warpperKey) as? [YXControlWarpper]
        if warppers == nil {
            warppers = [YXControlWarpper]()
        }
        let warpper = YXControlWarpper(controlEvents, action: action)
        warpper.ignoreEventTime = ignoreEventTime
        warppers!.append(warpper)
        objc_setAssociatedObject(self, &YXControlAssociatedKeys.warpperKey, warppers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.addTarget(warpper, action: #selector(YXControlWarpper.invoke(_:)), for: controlEvents)
        return self
    }
    
    @discardableResult func removeAction(for controlEvents: UIControl.Event ) -> Self {
        var warppers = objc_getAssociatedObject(self, &YXControlAssociatedKeys.warpperKey) as? [YXControlWarpper]
        if warppers == nil || warppers!.count == 0 {
            return self
        }
        warppers = warppers?.filter({ (item) -> Bool in
            return item.controlEvents != controlEvents
        })
        objc_setAssociatedObject(self, &YXControlAssociatedKeys.warpperKey, warppers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    @discardableResult func removeAllAction() -> Self {
        objc_setAssociatedObject(self, &YXControlAssociatedKeys.warpperKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    @discardableResult func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
    
    @discardableResult func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult
    func contentHorizontalAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = alignment
        return self
    }
    
    @discardableResult
    func contentVerticalAlignment(_ alignment: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = alignment
        return self
    }
    
}

private class YXControlWarpper: NSObject {
    
    var controlEvents: UIControl.Event?
    
    /// 记录上次点击相应事件的时间戳
    var timeInterval: TimeInterval = 0
    
    /// 防重复点击间隔
    var ignoreEventTime: Double = 0
    
    var action: ((UIControl) -> Void)?
    
    init(_ controlEvents: UIControl.Event, action: @escaping (UIControl) -> Void) {
        self.controlEvents = controlEvents
        self.action = action
    }
    
    @objc func invoke(_ sender: UIControl) {
        let current = NSDate().timeIntervalSince1970
        
        if fabs(current - timeInterval) > ignoreEventTime {
            self.timeInterval = current
            self.action?(sender)
        }
    }
}
