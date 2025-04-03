// 
//  UIAlertContro+Chainable.swift
//  YXKitSwift
//
//  Created by zxw on 2023/11/28.
//

import UIKit

public extension UIAlertController {
    
    @discardableResult func addCancelAction(_ title: String, action: (() -> Void)? = nil) -> Self {
        self.addAction(UIAlertAction(title: "", style: .cancel) { _ in
            action?()
        })
        return self
    }
    
    @discardableResult func addAction(_ title: String, action: @escaping () -> Void) -> Self {
        self.addAction(UIAlertAction(title: "", style: .default) { _ in
            action()
        })
        
        return self
    }
    
    /// present弹出
    func present(_ fromVC: UIViewController?) {
        fromVC?.present(self, animated: true, completion: nil)
    }
    
}
