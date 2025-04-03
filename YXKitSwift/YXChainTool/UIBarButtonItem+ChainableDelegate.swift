//
//  UIBarButtonItem+ChainableDelegate.swift
//  YXChainDemo
//
//  Created by 张鑫 on 2023/3/23.
//  Copyright © 2023 yxqiche. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
	
	convenience init(title: String?, style: UIBarButtonItem.Style, action: @escaping (UIBarButtonItem) -> Void) {
		self.init(title: title, style: style, target: nil, action: nil)
		self.actionClosure = action
		self.target = self
		self.action = #selector(barButtonItemPressed(_:))
	}
	
	convenience init(image: UIImage?, style: UIBarButtonItem.Style, action: @escaping (UIBarButtonItem) -> Void) {
		self.init(image: image, style: style, target: nil, action: nil)
		self.actionClosure = action
		self.target = self
		self.action = #selector(barButtonItemPressed(_:))
	}
	
	@discardableResult
	func addAction(_ action: ((UIBarButtonItem) -> Void)?) -> Self {
		self.actionClosure = action
		self.target = self
		self.action = #selector(barButtonItemPressed(_:))
		return self
	}
	
	private struct AssociatedKeys {
		static var ActionClosure = "UIBarButtonItem_ActionClosure"
	}
	
	private var actionClosure: ((UIBarButtonItem) -> Void)? {
		get {
			return objc_getAssociatedObject(self, &AssociatedKeys.ActionClosure) as? ((UIBarButtonItem) -> Void)
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.ActionClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	@objc private func barButtonItemPressed(_ sender: UIBarButtonItem) {
		actionClosure?(sender)
	}
}

