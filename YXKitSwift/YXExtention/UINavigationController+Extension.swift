//
//  UINavigationController+Extension.swift
//  YXKitSwift
//
//  Created by 张鑫 on 2023/12/27.
//

import UIKit

@objc public extension UINavigationController {
    
    /// pop指定页面个数
    /// - Parameters:
    ///   - count: pop几个页面
    ///   - animated: 是否动画
    func yx_popVC(count: Int, animated: Bool) {
        
        let allCount = self.viewControllers.count
        let index = allCount - 1 - count
        
        if index < allCount, index >= 0 {
            self.popToViewController(self.viewControllers[allCount - 1 - count], animated: animated)
        } else {
            self.popToRootViewController(animated: animated)
        }
        
    }
}

public protocol YXNavControllersChangedProtocol: UINavigationControllerDelegate {
    var yx_controllersChanged: (([UIViewController]?) -> Void)? { get set }
}

public class YXNavControllersChangedDelegate: NSObject, YXNavControllersChangedProtocol {
    public var yx_controllersChanged: (([UIViewController]?) -> Void)?

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        yx_controllersChanged?(navigationController.viewControllers)
    }
}

public extension UINavigationController {
    /// 监听Nav 的 Controllers变化
    var yx_controllersChangedDelegate: YXNavControllersChangedProtocol? {
        get { return delegate as? YXNavControllersChangedProtocol }
        set { delegate = newValue }
    }
}
