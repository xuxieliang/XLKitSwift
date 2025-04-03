//
//  NSMutableString+Extension.swift
//  YXKitSwift
//
//  Created by zxw on 2022/4/20.
//

import UIKit

public extension NSMutableAttributedString {
    
    /// 文本字体
    @discardableResult func yx_setFont(_ font: UIFont) -> Self {
        let subRange = NSRange(location: 0, length: self.string.count)
        addAttribute(.font, value: font, range: subRange)
        return self
    }
    
    /// 文本字体，指定区间
    @discardableResult func yx_setFont(_ font: UIFont, range: NSRange?) -> Self {
        guard let subRange = range else { return self }
        addAttribute(.font, value: font, range: subRange)
        return self
    }
    
    /// 文本字体，指定文本
    @discardableResult func yx_setFont(_ font: UIFont, subString: String?) -> Self {
        guard let subString = subString, subString.count > 0, let subRange = self.string.yx_range(of: subString) else { return self }
        addAttribute(.font, value: font, range: subRange)
        return self
    }
    
    /// 文本颜色
    @discardableResult func yx_setTextColor(_ color: UIColor) -> Self {
        let subRange = NSRange(location: 0, length: self.string.count)
        addAttribute(.foregroundColor, value: color, range: subRange)
        return self
    }
    
    /// 文本颜色，指定区间
    @discardableResult func yx_setTextColor(_ color: UIColor, range: NSRange?) -> Self {
        guard let subRange = range else { return self }
        addAttribute(.foregroundColor, value: color, range: subRange)
        return self
    }
    
    /// 文本颜色，指定文本
    @discardableResult func yx_setTextColor(_ color: UIColor, subString: String?) -> Self {
        guard let subString = subString, subString.count > 0, let subRange = self.string.yx_range(of: subString) else { return self }
        addAttribute(.foregroundColor, value: color, range: subRange)
        return self
    }
    
    /// 下划线颜色/默认风格单下划线
    @discardableResult func yx_setUnderlineColor(_ color: UIColor, style: NSUnderlineStyle = .single, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.underlineColor, value: color, range: rg)
        addAttribute(.underlineStyle, value: style.rawValue, range: rg)
        return self
    }
    
    /// 背景颜色
    @discardableResult func yx_setBackgroundColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.backgroundColor, value: color, range: rg)
        return self
    }
    
    /// 删除线颜色/默认风格单删除线
    @discardableResult func yx_setStrikethroughColor(_ color: UIColor, style: NSUnderlineStyle = .single, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.strikethroughColor, value: color, range: rg)
        addAttribute(.strikethroughStyle, value: style.rawValue, range: rg)
        return self
    }
    
    /// 设置超链接
    @discardableResult func yx_setLink(_ urlString: String, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.link, value: urlString, range: rg)
        return self
    }
    
    /// 设置文本倾斜
    @discardableResult func yx_setObliqueness(_ obliqueness: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.obliqueness, value: obliqueness, range: rg)
        return self
    }
    
    /// 设置文本加粗
    @discardableResult func yx_setExpansion(_ expansion: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.expansion, value: expansion, range: rg)
        return self
    }
    
    /// 设置文字间距
    @discardableResult func yx_setKern(_ kern: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        addAttribute(.kern, value: kern, range: rg)
        return self
    }
    
    // MARK: 段落设置
    
    private func getParagraphStyle(_ range: NSRange) -> NSMutableParagraphStyle {
        var rg = range
        if let style = attribute(.paragraphStyle, at: rg.location, effectiveRange: &rg) as? NSMutableParagraphStyle {
            return style
        }
        return NSMutableParagraphStyle()
    }
    
    /// 设置行间距
    @discardableResult func yx_setLineSpacing(_ lineSpacing: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        let paragraphStyle = getParagraphStyle(rg)
        paragraphStyle.lineSpacing = lineSpacing
        addAttribute(.paragraphStyle, value: paragraphStyle, range: rg)
        return self
    }
    
    /// 设置段落间距
    @discardableResult func yx_setParagraphSpacing(_ paragraphSpacing: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        let paragraphStyle = getParagraphStyle(rg)
        paragraphStyle.paragraphSpacing = paragraphSpacing
        addAttribute(.paragraphStyle, value: paragraphStyle, range: rg)
        return self
    }
    
    /// 设置首行缩进
    @discardableResult func yx_setFirstLineHeadIndent(_ firstLineHeadIndent: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        let paragraphStyle = getParagraphStyle(rg)
        paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
        addAttribute(.paragraphStyle, value: paragraphStyle, range: rg)
        return self
    }
    
    /// 设置文本缩进
    @discardableResult func yx_setHeadIndent(_ headIndent: CGFloat, range: NSRange? = nil) -> Self {
        let rg = range ?? NSRange(location: 0, length: self.string.count)
        let paragraphStyle = getParagraphStyle(rg)
        paragraphStyle.headIndent = headIndent
        addAttribute(.paragraphStyle, value: paragraphStyle, range: rg)
        return self
    }
}

// MARK: 图文混排
public extension NSMutableAttributedString {
    
    /// 插入一张图片
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图片大小
    ///   - index: 插入位置
    @discardableResult func yx_insertImage(_ image: UIImage?, size:(CGFloat, CGFloat), at index: Int) -> Self {
        guard let image = image else { return self }
        let attchment = NSTextAttachment()
        attchment.image = image
        attchment.bounds = CGRect(x: 0, y: 0, width: size.0, height: size.1)
        let string = NSAttributedString(attachment: attchment)
        self.insert(string, at: index)
        return self
    }
    
    /// 最后面拼接一张图片
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图片大小
    @discardableResult func yx_appendImage(_ image: UIImage?, size:(CGFloat, CGFloat)) -> Self {
        guard let image = image else { return self }
        let attchment = NSTextAttachment()
        attchment.image = image
        attchment.bounds = CGRect(x: 0, y: 0, width: size.0, height: size.1)
        let string = NSAttributedString(attachment: attchment)
        self.append(string)
        return self
    }
    
}
