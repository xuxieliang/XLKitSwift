//
//  TCKitTool.swift
//  TCKit
//
//  Created by zxw on 2023/11/28.
//

import UIKit

// MARK: 设备尺寸信息
public func yx_screenW() -> CGFloat {
    return UIScreen.main.bounds.width
}

public func yx_screenH() -> CGFloat {
    return UIScreen.main.bounds.height
}

public func yx_statusBar_H() -> CGFloat {
    var height: CGFloat? = 0
    
    if #available(iOS 13.0, *) {
        height = UIApplication.shared.windows.first?.safeAreaInsets.top
        height = (height ?? 0) > 0 ? height : UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height
    } else {
        height = UIApplication.shared.statusBarFrame.height
    }
    return height ?? 0
}

public func yx_safeArea_Top() -> CGFloat {
    return yx_statusBar_H() + 44
}

public func yx_safeArea_Bottom() -> CGFloat {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
    } else {
        return yx_statusBar_H() > 20 ? 34 : 0
    }
}

public func yx_safeFrame() -> CGRect {
    return CGRect(x: 0, y: yx_safeArea_Top(), width: yx_screenW(), height: yx_screenH() - yx_safeArea_Top() - yx_safeArea_Bottom())
}

public func yx_safeArea_Body() -> CGFloat {
    return yx_screenH() - yx_safeArea_Top() - yx_safeArea_Bottom()
}

public func yx_scale375() -> CGFloat {
    return yx_screenW() / 375.0
}

// MARK: 设备信息

public func yx_getIDFV() -> String {
    return UIDevice.current.identifierForVendor?.uuidString ?? ""
}

public func yx_getUUID() -> String {
    return NSUUID().uuidString
}

public func yx_iOSVersion() -> String {
    return UIDevice.current.systemVersion
}

public func yx_appInfo() -> [String: Any]? {
    return Bundle.main.infoDictionary
}

public func yx_appVersion() -> String {
    return yx_appInfo()?["CFBundleShortVersionString"] as? String ?? ""
}

public func yx_appBuild() -> String {
    return yx_appInfo()?["CFBundleVersion"] as? String ?? ""
}

// MARK: 当前页面信息

public func yx_keyWindow() -> UIWindow? {
    return UIApplication.shared.keyWindow
}

public func yx_currentVC() -> UIViewController? {
    if let vc = yx_keyWindow()?.rootViewController {
        return findBestViewController(vc)
    }
    return nil
}

public func yx_currentNav() -> UINavigationController? {
    return yx_currentVC()?.navigationController
}

public func yx_currentTab() -> UITabBarController? {
    return yx_currentVC()?.tabBarController
}

private func findBestViewController(_ vc: UIViewController) -> UIViewController {
    if let presented = vc.presentedViewController, presented.isBeingDismissed == false {
        return findBestViewController(presented)
        
    } else if let svc = vc as? UISplitViewController {
        if let last = svc.viewControllers.last {
            return findBestViewController(last)
        } else {
            return vc
        }
    } else if let nav = vc as? UINavigationController {
        
        if let top = nav.topViewController {
            return findBestViewController(top)
        } else {
            if let tab = UIApplication.shared.delegate?.window??.rootViewController as? UITabBarController, tab.selectedViewController === nav, tab.selectedIndex >= 4, let top = tab.moreNavigationController.topViewController {
                return findBestViewController(top)
            } else {
                return vc
            }
        }
    } else if let tab = vc as? UITabBarController {
        if let select = tab.selectedViewController {
            return findBestViewController(select)
        } else {
            return vc
        }
    } else {
        return vc
    }
}
