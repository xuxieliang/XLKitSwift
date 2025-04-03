//
//  UIView+Chainable.swift
//  YXKitSwift
//
//  Created by zhuxuewei on 2018/5/25.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit

public protocol ViewChainable {}

public extension ViewChainable where Self: UIView {
    
    /*
     可以在闭包内配置view的各种属性
     discardableResult 关键值的作用是 忽略返回值没有变量接收时的警告⚠️
     */
    @discardableResult
    func config(config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
    
//MARK: frame相关
    
    init(x: NumberProtocol, y: NumberProtocol, width: NumberProtocol, height: NumberProtocol) {
        self.init(frame: CGRect(x: x.doubleValue, y: y.doubleValue, width: width.doubleValue, height: height.doubleValue))
    }
    
    init(x: Int, y: Int, width: Int, height: Int) {
         self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    init(x: Double, y: Double, width: Double, height: Double) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    @available(*, deprecated, message: "Use minY(_:) instead")
    @discardableResult func top(_ top: CGFloat) -> Self {
        self.minY = top
        return self
    }
    
    @discardableResult
    func minY(_ minY: CGFloat) -> Self {
        self.minY = minY
        return self
    }
    
    @available(*, deprecated, message: "Use minX(_:) instead")
    @discardableResult func left(_ left: CGFloat) -> Self {
        self.minX = left
        return self
    }
    
    @discardableResult
    func minX(_ minX: CGFloat) -> Self {
        self.minX = minX
        return self
    }
    
    @available(*, deprecated, message: "Use maxY(_:) instead")
    @discardableResult func bottom(_ bottom: CGFloat) -> Self {
        self.maxY = bottom
        return self
    }
    
    @discardableResult
    func maxY(_ maxY: CGFloat) -> Self {
        self.maxY = maxY
        return self
    }
    
    @available(*, deprecated, message: "Use maxX(_:) instead")
    @discardableResult func right(_ right: CGFloat) -> Self {
        self.maxX = right
        return self
    }
    
    @discardableResult
    func maxX(_ maxX: CGFloat) -> Self {
        self.maxX = maxX
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> Self {
        self.height = height
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> Self {
        self.width = width
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> Self {
        self.size = size
        return self
    }
    
    @discardableResult
    func size(_ w: CGFloat, _ h: CGFloat) -> Self {
        self.size = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func center(_ center: CGPoint) -> Self {
        self.center = center
        return self
    }
    
    @discardableResult
    func center(_ x: CGFloat, _ y: CGFloat) -> Self {
        self.center = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func centerX(_ centerX: CGFloat) -> Self {
        self.centerX = centerX
        return self
    }
    
    @discardableResult
    func centerY(_ centerY: CGFloat) -> Self {
        self.centerY = centerY
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func frame(_ x: CGFloat, _ y:CGFloat, _ w: CGFloat, _ h: CGFloat) -> Self {
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        return self
    }
    
    @discardableResult
    func bounds(_ bounds: CGRect) -> Self {
        self.bounds = bounds
        return self
    }
    
//MARK: UI相关
    
    /// 添加到父视图上
    @discardableResult
    func addHere(_ superView: UIView?) -> Self {
        superView?.addSubview(self)
        return self
    }
    
    @discardableResult
    func addSubview(_ view: UIView?) -> Self {
        if let view = view {
            addSubview(view)
        }
        return self
    }
    
    /// 想链式编程用这个，其他用addSubview
    @discardableResult
    func addOptionalSubview(_ view: UIView?) -> Self {
        if let view = view {
            addSubview(view)
        }
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    @discardableResult
    func backgroundColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.backgroundColor = UIColor(hex, alpha)
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ isClips: Bool) -> Self {
        self.clipsToBounds = isClips
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat, position: UIRectCorner = .allCorners) -> Self {
        if position == .allCorners {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: position, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let layer = CAShapeLayer()
            layer.frame = bounds
            layer.path = path.cgPath
            self.layer.mask = layer
        }
        return self
    }
    
    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> Self {
        self.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func borderColor(_ borderColor: UIColor?) -> Self {
        self.layer.borderColor = borderColor?.cgColor
        return self
    }
    @discardableResult
    func borderColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.layer.borderColor = UIColor(hex, alpha).cgColor
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    func shadowColor(_ shadowColor: UIColor?) -> Self {
        self.layer.shadowColor = shadowColor?.cgColor
        return self
    }
    @discardableResult
    func shadowColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.layer.shadowColor = UIColor(hex, alpha).cgColor
        return self
    }
    
    func shadowOffset(_ shadowOffset: CGSize) -> Self {
        self.layer.shadowOffset = shadowOffset
        return self
    }
    
    func shadowOffset(_ width: CGFloat, height: CGFloat) -> Self {
        self.layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    func shadowRadius(_ shadowRadius: CGFloat) -> Self {
        self.layer.shadowRadius = shadowRadius
        return self
    }
    
    func shadowOpacity(_ shadowOpacity: Float) -> Self {
        self.layer.shadowOpacity = shadowOpacity
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func eachSubview(_ each: (UIView)->()) -> Self {
        subviews.forEach { each($0) }
        return self
    }
    
    @discardableResult
    func removeAllSubview() -> Self {
        subviews.forEach { $0.removeFromSuperview() }
        return self
    }
    
    /// 背景渐变色
    /// - Parameters:
    ///   - colors: 2个渐变颜色
    ///   - startPoint: 开始点CGPoint 0-1
    ///   - endPoint: 结束点CGPoint 0-1
    /// - Returns: UIView
    @discardableResult
    func gradientColors(_ colors: [UIColor], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) -> Self {
        guard colors.count == 2 else { return self }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colors.first!.cgColor, colors.last!.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = startPoint ?? CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint  = endPoint ?? CGPoint.init(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
        return self
    }
    
    //MARK: 事件相关
    /*
     给view添加一个点击事件
     */
    @discardableResult
    func tapAction(action:@escaping () -> ()) -> Self {
        
        // 先移除之前的单击手势，防止重复添加手势
        if let gestureRecognizers = self.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let tap = gesture as? UITapGestureRecognizer {
                    self.removeGestureRecognizer(tap)
                }
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.addGestureRecognizer(tap)
        objc_setAssociatedObject(self, &YXViewAssociatedKeys.tapKey, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
    
    /*
     给view添加一个点击事件
     */
    @discardableResult
    func tapAction(action:@escaping (UIView) -> ()) -> Self {
        
        // 先移除之前的单击手势，防止重复添加手势
        if let gestureRecognizers = self.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let tap = gesture as? UITapGestureRecognizer {
                    self.removeGestureRecognizer(tap)
                }
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.addGestureRecognizer(tap)
        objc_setAssociatedObject(self, &YXViewAssociatedKeys.tapKey, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
    
    /// 移除单击手势
    @discardableResult func removeTapGestureRecognizer() -> Self {
        if let gestureRecognizers = self.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let tap = gesture as? UITapGestureRecognizer {
                    self.removeGestureRecognizer(tap)
                }
            }
        }
        return self
    }
    
    /*
     给view添加一个双击事件
     */
    @discardableResult
    func doubleTapAction(action:@escaping (UIView, CGPoint) -> ()) -> Self {
        
        // 先移除之前的单击手势，防止重复添加手势
        removeDoubleTapGestureRecognizer()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
        
        if let onetap = self.gestureRecognizers?.first(where: { ($0 as? UITapGestureRecognizer)?.numberOfTapsRequired == 1 }) {
            onetap.require(toFail: tap)
        }
        
        objc_setAssociatedObject(self, &YXViewAssociatedKeys.doubleTapKey, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
    
    /// 移除双击手势
    @discardableResult func removeDoubleTapGestureRecognizer() -> Self {
        if let gestureRecognizers = self.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let tap = gesture as? UITapGestureRecognizer, tap.numberOfTapsRequired == 2 {
                    self.removeGestureRecognizer(tap)
                }
            }
        }
        objc_setAssociatedObject(self, &YXViewAssociatedKeys.doubleTapKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
        return self
    }
    
    /// 移除所有手势
    @discardableResult func removeAllGestureRecognizer() -> Self {
        if let gestureRecognizers = self.gestureRecognizers {
            gestureRecognizers.forEach({ self.removeGestureRecognizer($0) })
        }
        return self
    }
    
    @discardableResult
    func userInteractionEnabled(enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    func multipleTouchEnabled(enabled: Bool) -> Self {
        self.isMultipleTouchEnabled = enabled
        return self
    }
}


private struct YXViewAssociatedKeys {
    static var tapKey = "kTapActionKey"
    static var doubleTapKey = "kDoubleTapActionKey"
}

extension UIView: ViewChainable
{
    @objc fileprivate func tapGestureRecognizerAction(sender: UITapGestureRecognizer) {
        if sender.numberOfTapsRequired == 1 {
            if let action = objc_getAssociatedObject(self, &YXViewAssociatedKeys.tapKey) as? () -> () {
                action()
            } else if let action = objc_getAssociatedObject(self, &YXViewAssociatedKeys.tapKey) as? (UIView) -> () {
                action(self)
            }
        } else if sender.numberOfTapsRequired == 2 {
            if let action = objc_getAssociatedObject(self, &YXViewAssociatedKeys.doubleTapKey) as? (UIView, CGPoint) -> () {
                action(self, sender.location(in: self))
            }
        }
    }
}

public extension UIImageView {
    
    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    @discardableResult
    func image(_ imageName: String?) -> Self {
        self.image = UIImage(named: imageName ?? "")
        return self
    }
    
    @discardableResult
    func highlightedImage(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    @discardableResult
    func highlightedImage(_ imageName: String?) -> Self {
        self.image = UIImage(named: imageName ?? "")
        return self
    }
    
    @discardableResult
    func animationImages(_ images: [UIImage]?) -> Self {
        self.animationImages = images
        return self
    }
    
    @discardableResult
    func highlightedAnimationImages(_ images: [UIImage]?) -> Self {
        self.animationImages = images
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self
    }
    
    @discardableResult
    func animationDuration(_ duration: TimeInterval) -> Self {
        self.animationDuration = duration
        return self
    }
    
    @discardableResult
    func animationRepeatCount(_ repeatCount: Int) -> Self {
        self.animationRepeatCount = repeatCount
        return self
    }
}

public extension UILabel {
    
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor!) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func textColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.textColor = UIColor(hex, alpha)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont!) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat, _ weight: UIFont.Weight = .regular) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ isAdjustFont: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = isAdjustFont
        return self
    }
    
    /// 是否长按复制
    /// - Parameter isCopy: 是否长按复制
    /// - Returns: self
    @discardableResult
    func longPressCopy(_ isCopy: Bool) -> Self {
        isUserInteractionEnabled = isCopy
        if isCopy {
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyAction(_:)))
            self.addGestureRecognizer(longPress)
        } else {
            if let longPress = self.gestureRecognizers?.first(where: { (gestureRecognizer) -> Bool in
                return gestureRecognizer is UILongPressGestureRecognizer
            }) {
                
                self.removeGestureRecognizer(longPress)
            }
        }
        return self
    }
    @objc func longPressCopyAction(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel,
            gestureRecognizer.state == .began,
            label.text != nil {
            self.becomeFirstResponder()
            let item = UIMenuItem(title: "复制", action: #selector(copyAction))
            let menu = UIMenuController.shared
            menu.menuItems = [item]
            menu.arrowDirection = .default
            menu.setTargetRect(self.bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(copyAction){
                return true
            }
            return false
        }
    
    @objc func copyAction() {
        if self.text != nil {
            let pasteboard = UIPasteboard.general
            pasteboard.string = self.text
        }
    }
    
    
    @discardableResult
    func minimumScaleFactor(_ scale: CGFloat) -> Self {
        self.minimumScaleFactor = scale
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString?) -> Self {
        self.attributedText = text
        return self
    }
    
    @discardableResult
    func shadowColor(_ color: UIColor?) -> Self {
        self.shadowColor = color
        return self
    }
    
    @discardableResult
    func shadowColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.shadowColor = UIColor(hex, alpha)
        return self
    }
    
    @discardableResult
    func highlightedTextColor(_ color: UIColor?) -> Self {
        self.highlightedTextColor = color
        return self
    }
    
    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        self.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func baselineAdjustment(_ adjustment: UIBaselineAdjustment) -> Self {
        self.baselineAdjustment = adjustment
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isBool: Bool) -> Self {
        self.isHighlighted = isBool
        return self
    }
    
    @discardableResult
    func yx_sizeToFit() -> Self {
        self.sizeToFit()
        return self
    }
    
    /// 设置数字的颜色和字体
    @discardableResult
    func addNumberAttributed(color: UIColor, font: UIFont) -> Self {
        addAttributed("\\d+", attrs: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return self
    }
    
    /// 设置数字的字体
    @discardableResult
    func addNumberAttributed(_ font: UIFont) -> Self {
        addAttributed("\\d+", attrs: [NSAttributedString.Key.font: font])
        return self
    }
    
    /// 设置数字的颜色
    @discardableResult
    func addNumberAttributed(_ color: UIColor) -> Self {
        addAttributed("\\d+", attrs: [NSAttributedString.Key.foregroundColor: color])
        return self
    }
    
    /// 设置指定文本的颜色
    @discardableResult
    func addAttributed(subString: String?, color: UIColor) -> Self {
        guard let subString = subString else { return self }
        addAttributed(subString, attrs: [NSAttributedString.Key.foregroundColor: color])
        return self
    }
    
    /// 设置指定文本的字体
    @discardableResult
    func addAttributed(subString: String?, font: UIFont) -> Self {
        guard let subString = subString else { return self }
        addAttributed(subString, attrs: [NSAttributedString.Key.font: font])
        return self
    }
    
    /// 设置指定文本的颜色和字体
    @discardableResult
    func addAttributed(subString: String?, color: UIColor, font: UIFont) -> Self {
        guard let subString = subString else { return self }
        addAttributed(subString, attrs: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        return self
    }
    
    /// 设置匹配正则文本的颜色
    @discardableResult
    func addAttributed(regex: String?, color: UIColor? = nil, font: UIFont? = nil) -> Self {
        guard let regex = regex else { return self }
        if color != nil { addAttributed(regex, attrs: [NSAttributedString.Key.foregroundColor: color!]) }
        if font != nil { addAttributed(regex, attrs: [NSAttributedString.Key.font: font!]) }
        return self
    }
    
    /// 设置匹配正则表达式内的富文本
    /// - Parameters:
    ///   - regex: 正则表达式，也可以直接输入字符串
    ///   - color: 颜色
    ///   - font: 字体
    ///   - config: 自定义NSMutableAttributedString
    /// - Returns: UILabel
    @discardableResult
    func addAttributed(_ regex: String, attrs: [NSAttributedString.Key : Any]) -> Self {
        
        let attributeString_temp = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        let string = text ?? ""

        do {
            let regexExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options())
            let result = regexExpression.matches(in: string, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, string.count))
            for item in result {
                attributeString_temp.addAttributes(attrs, range: item.range)
            }
            attributedText = attributeString_temp
        } catch {
            print("yx_numberColor Failed with error: \(error)")
        }
        return self
    }
    
    /// 设置行高
    @discardableResult
    func lineSpacing(_ spacing: CGFloat) -> Self {
        guard text?.count ?? 0 > 0 else { return self }
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let attr = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text!.count))
        attributedText = attr
        return self
    }
    
    /// 自适应大小
    @discardableResult
    func sizeThatFits(width: CGFloat, height: CGFloat) -> Self {
        self.size = sizeThatFits(CGSize(width: width, height: height))
        return self
    }
    
    /// 设置文字渐变色，必须先addSubView，默认从左到右渐变
    /// - Parameter colors: 2个颜色
    /// - startPoint: 开始点CGPoint 0-1
    /// - endPoint: 结束点CGPoint 0-1
    /// - Returns: UILabel
    @discardableResult
    func textGradientColors(_ colors: [UIColor], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) -> Self {
        guard colors.count == 2 else { return self }
        let gradientView = UIView(frame: self.frame)
        frame(bounds).backgroundColor(.clear)
        let gradient = CAGradientLayer()
        gradient.colors = [colors[0].cgColor, colors[1].cgColor]
        gradient.startPoint = startPoint ?? CGPoint(x: 0, y: 0)
        gradient.endPoint = endPoint ?? CGPoint(x: 1, y: 0)
        gradient.frame = gradientView.bounds
        gradientView.layer.addSublayer(gradient)
        superview?.addSubview(gradientView)
        gradientView.mask = self
        
        return self
    }
    
}

public extension UIButton {
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat, _ weight: UIFont.Weight = .regular) -> Self {
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    @discardableResult
    func title(_ title: String?, color: UIColor? = nil, for state: UIControl.State) -> Self {
        setTitle(title, for: state)
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func image(_ imageName: String?, for state: UIControl.State) -> Self {
        setImage(UIImage(named: imageName ?? ""), for: state)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for state: UIControl.State) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ imageName: String?, for state: UIControl.State) -> Self {
        setBackgroundImage(UIImage(named: imageName ?? ""), for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor, for state: UIControl.State) -> Self {
        setBackgroundImage(UIImage.yx_image(color), for: state)
        return self
    }
    
    @discardableResult
    @available(iOS 9.0, *)
    func semanticContentAttribute(_ semanticContentAttribute: UISemanticContentAttribute) -> Self {
        self.semanticContentAttribute = semanticContentAttribute
        return self
    }
    
    @discardableResult
    func contentEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func adjustsImageWhenHighlighted(_ isAdjust: Bool) -> Self {
        self.adjustsImageWhenHighlighted = isAdjust
        return self
    }
    
    @discardableResult
    func adjustsImageWhenDisabled(_ isAdjust: Bool) -> Self {
        self.adjustsImageWhenDisabled = isAdjust
        return self
    }
    
    @discardableResult
    func showsTouchWhenHighlighted(_ isAdjust: Bool) -> Self {
        self.showsTouchWhenHighlighted = isAdjust
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func tintColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.tintColor = UIColor(hex, alpha)
        return self
    }
}

public extension UITextField {
    
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    @discardableResult
    func textColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.textColor = UIColor(hex, alpha)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat, _ weight: UIFont.Weight = .regular) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString?, textAttributes: [NSAttributedString.Key : Any]? = nil) -> Self {
        self.attributedText = text
        if let attributes = textAttributes {
            self.defaultTextAttributes = attributes
        }
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ text: NSAttributedString?) -> Self {
        self.attributedPlaceholder = text
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func borderStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }
    
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autocorrectionType
        return self
    }
    
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Self {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func clearsOnBeginEditing(_ isClear: Bool) -> Self {
        self.clearsOnBeginEditing = isClear
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ isAdjustFont: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = isAdjustFont
        return self
    }
    
    @discardableResult
    func minimumFontSize(_ minSize: CGFloat) -> Self {
        self.minimumFontSize = minSize
        return self
    }
    
    @discardableResult
    func background(_ image: UIImage?) -> Self {
        self.background = image
        return self
    }
    
    @discardableResult
    func disabledBackground(_ image: UIImage?) -> Self {
        self.disabledBackground = image
        return self
    }
    
    @discardableResult
    func clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }
    
    @discardableResult
    func leftView(_ view: UIView?) -> Self {
        self.leftView = view
        return self
    }
    
    @discardableResult
    func leftViewMode(_ mode: UITextField.ViewMode) -> Self {
        self.leftViewMode = mode
        return self
    }
    
    @discardableResult
    func rightView(_ view: UIView?) -> Self {
        self.rightView = view
        return self
    }
    
    @discardableResult
    func rightViewMode(_ mode: UITextField.ViewMode) -> Self {
        self.rightViewMode = mode
        return self
    }
    
    @discardableResult
    func inputView(_ view: UIView?) -> Self {
        self.inputView = view
        return self
    }
    
    @discardableResult
    func inputAccessoryView(_ view: UIView?) -> Self {
        self.inputAccessoryView = view
        return self
    }
}

public extension UITextView {
    
    @discardableResult
    func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func text(_ text: String!) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat, _ weight: UIFont.Weight = .regular) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    @discardableResult
    func textColor(_ hex: Int, _ alpha: CGFloat = 1) -> Self {
        self.textColor = UIColor(hex, alpha)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func selectedRange(_ selectedRange: NSRange) -> Self {
        self.selectedRange = selectedRange
        return self
    }
   
    @discardableResult
    func isEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }
    
    @discardableResult
    func isSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }
    
    @discardableResult
    func dataDetectorTypes(_ dataDetectorTypes: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = dataDetectorTypes
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Self {
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString!) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }
    
    @discardableResult
    func inputAccessoryView(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }
    
    @discardableResult
    func clearsOnInsertion(_ clearsOnInsertion: Bool) -> Self {
        self.clearsOnInsertion = clearsOnInsertion
        return self
    }
    
    @discardableResult
    func textContainerInset(_ textContainerInset: UIEdgeInsets) -> Self {
        self.textContainerInset = textContainerInset
        return self
    }
    
    func placeholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        let placeholderLabel = UILabel()
        placeholderLabel.attributedText = attributedPlaceholder
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = self.font ?? UIFont.systemFont(ofSize: 12.0)
        placeholderLabel.sizeToFit()
        self.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: self.textContainerInset.top)
        placeholderLabel.isHidden = !self.text.isEmpty
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: .main) { [weak self] _ in
            placeholderLabel.isHidden = !(self?.text.isEmpty ?? true)
        }
        return self
    }
    
    @discardableResult
    func maxLength(_ maxLength: Int) -> Self {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            if let text = self.text, text.count > maxLength {
                let index = text.index(text.startIndex, offsetBy: maxLength)
                self.text = String(text[text.startIndex..<index])
            }
        }
        return self
    }
    
}

public extension UIScrollView {
    
    @discardableResult
    func contentOffset(_ offset: CGPoint) -> Self {
        self.contentOffset = offset
        return self
    }
    
    @discardableResult
    func contentOffset(_ x: CGFloat, _ y: CGFloat) -> Self {
        self.contentOffset = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func contentSize(_ size: CGSize) -> Self {
        self.contentSize = size
        return self
    }
    
    @discardableResult
    func contentSize(_ w: CGFloat, _ h: CGFloat) -> Self {
        self.contentSize = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func contentInset(_ edgeInsets: UIEdgeInsets) -> Self {
        self.contentInset = edgeInsets
        return self
    }
    
    @discardableResult
    func contentInset(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        self.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @available(iOS 11.0, *)
    func contentInsetAdjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        self.contentInsetAdjustmentBehavior = behavior
        return self
    }
    
    @discardableResult
    func bounces(_ isBounces: Bool) -> Self {
        self.bounces = isBounces
        return self
    }
    
    @discardableResult
    func isDirectionalLockEnabled(_ isEnabled: Bool) -> Self {
        self.isDirectionalLockEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func alwaysBounceVertical(_ isAlways: Bool) -> Self {
        self.alwaysBounceVertical = isAlways
        return self
    }
    
    @discardableResult
    func alwaysBounceHorizontal(_ isAlways: Bool) -> Self {
        self.alwaysBounceHorizontal = isAlways
        return self
    }
    
    @discardableResult
    func isPagingEnabled(_ isEnabled: Bool) -> Self {
        self.isPagingEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isScrollEnabled(_ isEnabled: Bool) -> Self {
        self.isScrollEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func showsHorizontalScrollIndicator(_ isShow: Bool) -> Self {
        self.showsHorizontalScrollIndicator = isShow
        return self
    }
    
    @discardableResult
    func showsVerticalScrollIndicator(_ isShow: Bool) -> Self {
        self.showsVerticalScrollIndicator = isShow
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func scrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.scrollIndicatorInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func scrollIndicatorInsets(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        self.scrollIndicatorInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func indicatorStyle(_ style: UIScrollView.IndicatorStyle) -> Self {
        self.indicatorStyle = style
        return self
    }
    
    @discardableResult
    func decelerationRate(_ rate: CGFloat) -> Self {
        self.decelerationRate = UIScrollView.DecelerationRate(rawValue: rate)
        return self
    }
    
    @discardableResult
    func indexDisplayMode(_ mode: UIScrollView.IndexDisplayMode) -> Self {
        self.indexDisplayMode = mode
        return self
    }
    
    @discardableResult
    func delaysContentTouches(_ isDelays: Bool) -> Self {
        self.delaysContentTouches = isDelays
        return self
    }
    
    @discardableResult
    func canCancelContentTouches(_ isCanCancel: Bool) -> Self {
        self.canCancelContentTouches = isCanCancel
        return self
    }
    
    @discardableResult
    func minimumZoomScale(_ minScale: CGFloat) -> Self {
        self.minimumZoomScale = minScale
        return self
    }
    
    @discardableResult
    func maximumZoomScale(_ maxScale: CGFloat) -> Self {
        self.maximumZoomScale = maxScale
        return self
    }
    
    @discardableResult
    func zoomScale(_ scale: CGFloat) -> Self {
        self.zoomScale = scale
        return self
    }
    
    @discardableResult
    func bouncesZoom(_ isBouncesZoom: Bool) -> Self {
        self.bouncesZoom = isBouncesZoom
        return self
    }
    
    @discardableResult
    func scrollsToTop(_ isScrollsToTop: Bool) -> Self {
        self.scrollsToTop = isScrollsToTop
        return self
    }
    
    @discardableResult
    func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = mode
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        self.refreshControl = refreshControl
        return self
    }
}


public extension UIStackView {
    
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment) -> Self {
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    func addArrangedSubviews(_ views: [UIView]?) -> Self {
        if let views = views {
            for view in views {
                self.addArrangedSubview(view)
            }
        }
        return self
    }
}

    
extension UIView {

    /// minX
    var minX: CGFloat {
        get {
            return frame.minX
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// maxX
    var maxX: CGFloat {
        get {
            return frame.maxX
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue - tempFrame.width
            frame = tempFrame
        }
    }
    
    /// minY
    var minY: CGFloat {
        get {
            return frame.minY
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame = tempFrame
        }
    }
    
    /// maxY
    var maxY: CGFloat {
        get {
            return frame.maxY
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue - tempFrame.height
            frame = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    var topRight: CGPoint {
        get {
            return CGPoint(x: frame.maxX, y: frame.minY)
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue.x - tempFrame.width
            frame = tempFrame
        }
    }
    
    var leftBottom: CGPoint {
        get {
            return CGPoint(x: frame.minX, y: frame.maxY)
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue.y - tempFrame.height
            frame = tempFrame
        }
    }
    
    var rightBottom: CGPoint {
        get {
            return CGPoint(x: frame.maxX, y: frame.maxY)
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue.x - tempFrame.width
            tempFrame.origin.y = newValue.y - tempFrame.height
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
}
