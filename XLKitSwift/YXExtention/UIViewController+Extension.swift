//
//  UIViewController+Extension.swift
//  YXKitSwift
//
//  Created by zx on 2021/8/31.
//

import UIKit

@objc public extension UIViewController {
    
    /// 设置导航条右侧按钮
    @objc func yx_rightBarButtonItem(titles: [String], handler: (@escaping (UIBarButtonItem) -> Void)) {
        
        var array = [UIBarButtonItem]()
        
        for i in 0..<titles.count {
            let button = UIBarButtonItem(title: titles[i], style: .plain) { item in
                handler(item)
            }
            array.append(button)
        }
        
        navigationItem.rightBarButtonItems = array
    }
    
    /// 获取上一个VC
    static func yx_previousVC() -> UIViewController? {
        let count = yx_currentNav()?.viewControllers.count ?? 0
        if count > 1 {
            return yx_currentNav()?.viewControllers[count - 2];
        } else {
            return nil
        }
    }
}
