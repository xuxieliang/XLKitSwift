//
//  String+Extension.swift
//  Taoyuejia
//
//  Created by zxw on 2020/10/24.
//  Copyright © 2020 zxw. All rights reserved.
//

import UIKit

//MARK: 时间格式转换
public extension String {
    
    /// 时间戳 字符串 转换成 时间格式字符串
    /// - Parameter toFomat: 时间格式
    /// - Returns: description
    func yx_timeTransfer(toFomat: String) -> String? {
        guard let _ = Double(self) else { return nil }
        let date = Date(timeIntervalSince1970: Double(self)!)
        return date.yx_string(toFomat)
    }
    
    /// 时间字符串转 时间
    /// - Parameter fomat: 时间格式
    /// - Returns: description
    func yx_date(_ format: String) -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.date(from: self)
    }
    
    /// 时间字符串格式转换
    /// - Parameters:
    ///   - fromFomat: 初始时间格式
    ///   - toFomat: 目标时间格式
    /// - Returns: description
    func yx_timeTransfer(from fromFomat: String, to toFomat: String) -> String? {
        let date = yx_date(fromFomat)
        return date?.yx_string(toFomat)
    }
    
}

//MARK: 文本显示Size相关
public extension String {
    
    /// 获取文本显示 所占宽度
    /// - Parameter font: 字体类型
    /// - Returns: description
    func yx_width(font: UIFont) -> CGFloat {
        return yx_size(CGFloat(MAXFLOAT), font: font).width
    }
    
    /// 获取文本显示 所zhan
    /// - Parameters:
    ///   - maxWidth: 显示宽度
    ///   - font: 字体
    /// - Returns: description
    func yx_height(maxWidth: CGFloat, font: UIFont) -> CGFloat {
        return yx_size(maxWidth, font: font).height
    }
    
    /// 获取文本显示 所占size
    /// - Parameters:
    ///   - maxWidth: 显示宽度
    ///   - font: 字体
    /// - Returns: description
    func yx_size(_ maxWidth: CGFloat, font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font:font]
        let rect = self.boundingRect(with: CGSize(width: Double(maxWidth), height: Double(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return rect.size
    }
}

//MARK: 数据转换相关
public extension String {
    var yx_toInt: Int? {
        return Int(self)
    }
    
    var yx_toDouble: Double? {
        return Double(self)
    }
    
    var yx_toFloat: Float? {
        return Float(self)
    }
    
    var yx_toJson: [String: Any]? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] else { return nil }
        return json
    }
    
    var yx_toJsonArray: [[String: Any]]? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]] else { return nil }
        return json
    }
    
}

//MARK: 汉字相关处理
public extension String {
    
    /// 字符串中是否包含汉字
    /// - Returns: description
    func yx_isContainChinese() -> Bool {
        for ch in self.unicodeScalars {
            // 中文字符范围：0x4e00 ~ 0x9fff
            if (0x4e00 < ch.value  && ch.value < 0x9fff) {
                return true
            }
        }
        return false
    }
    
    /// 转换为带音标的拼音
    /// - Returns: description
    func yx_transformToPinyin() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false);
        let pinyin = stringRef as String;
        return pinyin
    }
    
    /// // 转换为不带音标的拼音
    /// - Returns: description
    func yx_transformToPinyinWithoutPhoneticSymbol() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false);
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false);
        let pinyin = stringRef as String;

        return pinyin
    }
    
    /// 获取拼音大写首字符
    /// - Returns:
    func yx_getPinyinUpperHead() -> String {
        // 字符串转换为首字母大写
        let pinyin = self.yx_transformToPinyinWithoutPhoneticSymbol()
        return String(pinyin.first ?? "#").uppercased()
    }
}

//MARK: 字符串截取
public extension String {

    /// 截取 from 位置后的所有字符，from 超过字符串长度，返回空字符 ""
    func yx_subString(from: Int) -> String {
        if from >= self.count {
            return ""
        }
        let rang = self.index(startIndex, offsetBy: from)..<self.endIndex
        return String(self[rang])
    }

    /// 从起始位置开始截取到 to 位置的所有字符，to 超过字符串长度，返回整个字符串
    func yx_subString(to: Int) -> String {
        if to >= self.count {
            return self;
        }
        let rang = self.startIndex..<self.index(startIndex, offsetBy: to)
        return String(self[rang])
    }

    /// 截取 location 位置后的 length位长度的字符，location 超过字符串长度，返回空字符 ""；
    /// location + length 超过字符串长度，返回 location 位置后的所有字符
    func yx_subString(location:Int, length:Int) -> String {
        if location >= self.count {
            return ""
        }
        if location + length >= self.count {
            return self
        }
        let locationIndex = self.index(startIndex, offsetBy: location)
        let range = locationIndex..<self.index(locationIndex, offsetBy: length)
        return String(self[range])
    }
    
    /// 替换字符串， "18515880183".replaceSubrange(location: 3, length: 4, with: "xxxx")   -> "185xxxx0183"
    /// - Parameters:
    ///   - location: 起始位置
    ///   - length: 长度
    ///   - newString: 新的字符串
    mutating func yx_replaceSubrange(location:Int, length:Int, with newString: String) {
        if let rg = Range(NSMakeRange(location, length), in: self) {
            replaceSubrange(rg, with: newString)
        }
    }
    
    /// 替换字符串， "18515880183".replaceSubrange(location: 3, length: 4, with: "xxxx")   -> "185xxxx0183"
    /// - Parameters:
    ///   - location: 起始位置
    ///   - length: 长度
    ///   - newString: 新的字符串
    func yx_replaceSubrange(location:Int, length:Int, with newString: String) -> String {
        var testString = self
        if let rg = Range(NSMakeRange(location, length), in: testString) {
             testString.replaceSubrange(rg, with: newString)
            return testString
        }
        return self
    }
    
    /// 间隔x个字符，插入某个字符
    /// - Parameters:
    ///   - string: 插入字符
    ///   - spaceCount: 间隔字符个数
    /// - Returns: 新字符串
    func yx_insert(_ string: String?, spaceCount: Int) -> String {
        var resultString = String()
        for (index, aString) in self.enumerated() {
            if index % spaceCount == 0, let string = string {
                resultString.append(string)
            }
            resultString.append(aString)
        }
        return resultString
    }
}

// MARK: 空字符串拼接
extension String? {
    static func +(lhs: String?, rhs: String?) -> String {
        return (lhs ?? "") + (rhs ?? "")
    }
}

// MARK: 字符串比较
public extension String {
    
    /// 是否包含某 字符串
    /// - Parameters:
    ///   - other: 比较字符串
    ///   - ignoringCase: 是否忽略大小写
    /// - Returns: 是否包含
    func yx_contains(_ other: String?, ignoringCase: Bool = false) -> Bool {
        guard let str = other else { return false }
        if ignoringCase {
            return self.lowercased().contains(str.lowercased())
        } else {
            return self.contains(str)
        }
    }
    
    /// 比较字符串是否相等
    /// - Parameters:
    ///   - other: 比较字符串
    ///   - ignoringCase: 是否忽略大小写
    /// - Returns: 是否包含
    func yx_isEqual(_ other: String?, ignoringCase: Bool = false) -> Bool {
        guard let str = other else { return false }
        if ignoringCase {
            return self.lowercased() == str.lowercased()
        } else {
            return self == str
        }
    }
}

// MARK: 富文本相关
public extension String {
    
    /// 获取NSRange
    func yx_range(of subString: String?) -> NSRange? {
        guard let sub = subString else { return nil }
        if let rg = self.range(of: sub) {
            return NSRange(rg, in: self)
        }
        return nil
    }
    
    /// 转换成富文本
    func yx_attributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    /// 文本字体
    @discardableResult func yx_setFont(_ font: UIFont, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setFont(font, range: range)
    }
    
    /// 文本颜色
    @discardableResult func yx_setTextColor(_ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setTextColor(color, range: range)
    }
    
    /// 下划线颜色/默认风格单下划线
    @discardableResult func yx_setUnderlineColor(_ color: UIColor, style: NSUnderlineStyle = .single, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setUnderlineColor(color, style: style, range: range)
    }
    
    /// 背景颜色
    @discardableResult func yx_setBackgroundColor(_ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setBackgroundColor(color, range: range)
    }
    
    /// 删除线颜色/默认风格单删除线
    @discardableResult func yx_setStrikethroughColor(_ color: UIColor, style: NSUnderlineStyle = .single, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setStrikethroughColor(color, style: style,range: range)
    }
    
    /// 设置超链接
    @discardableResult func yx_setLink(_ urlString: String, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setLink(urlString, range: range)
    }
    
    /// 设置文本倾斜
    @discardableResult func yx_setObliqueness(_ obliqueness: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setObliqueness(obliqueness, range: range)
    }
    
    /// 设置文本加粗
    @discardableResult func yx_setExpansion(_ expansion: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setExpansion(expansion, range: range)
    }
    
    /// 设置文字间距
    @discardableResult func yx_setKern(_ kern: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setKern(kern, range: range)
    }
    
    // MARK: 段落设置
    
    
    /// 设置行间距
    @discardableResult func yx_setLineSpacing(_ lineSpacing: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setLineSpacing(lineSpacing, range: range)
    }
    
    /// 设置段落间距
    @discardableResult func yx_setParagraphSpacing(_ paragraphSpacing: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setParagraphSpacing(paragraphSpacing, range: range)
    }
    
    /// 设置首行缩进
    @discardableResult func yx_setFirstLineHeadIndent(_ firstLineHeadIndent: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setFirstLineHeadIndent(firstLineHeadIndent, range: range)
    }
    
    /// 设置文本缩进
    @discardableResult func yx_setHeadIndent(_ headIndent: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_setHeadIndent(headIndent, range: range)
    }
    
    /// 插入一张图片
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图片大小
    ///   - index: 插入位置
    @discardableResult func yx_insertImage(_ image: UIImage?, size:(CGFloat, CGFloat), at index: Int) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_insertImage(image, size: size, at: index)
        
    }
    
    /// 最后面拼接一张图片
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图片大小
    @discardableResult func yx_appendImage(_ image: UIImage?, size:(CGFloat, CGFloat)) -> NSMutableAttributedString {
        return self.yx_attributedString().yx_appendImage(image, size: size)
    }
    
}

// MARK: url处理
public extension String {

    // 提取url参数
    func yx_getURLParameters() -> [String: String]? {
        guard let urlComponents = URLComponents(string: self),
              let queryItems = urlComponents.queryItems else {
            return nil
        }

        var parameters: [String: String] = [:]
        for item in queryItems {
            parameters[item.name] = item.value ?? ""
        }

        return parameters
    }

}
