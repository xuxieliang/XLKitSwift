//
//  UIStackView+YXAdd.swift
//  YXKitSwift
//
//  Created by 张鑫 on 2023/2/28.
//

import UIKit

public extension UIStackView {

	/// 移除ArrangedSubview，并removeFromSuperview
	func yx_removeArrangedSubview() {
		self.arrangedSubviews.forEach({
			self.removeArrangedSubview($0)
			$0.removeFromSuperview()
		})
	}

}
