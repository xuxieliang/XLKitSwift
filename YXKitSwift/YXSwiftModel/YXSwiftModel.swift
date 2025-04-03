//
//  YXSwiftModel.swift
//  Taoyuejia
//
//  Created by zxw on 2020/10/9.
//  Copyright © 2020 zxw. All rights reserved.
//  HandyJSON 中间件

import UIKit
import HandyJSON

open class YXSwiftModel: HandyJSONs {
    
    required public init() {
    }
    
    /// 自定义属性映射关系,及解析路径
    ///  例：return [self.yx_name <-- "name",
    ///             self.yx_age <-- "data.age"]
    ///
    /// - Returns: return value description
    open func yx_propertyMapper() -> [CustomMappingKeyValueTuple]? {
        return nil
    }
    
    /// 序列化完成之后会执行，用于自定义更新
    open func yx_update() {
        
    }
}


public protocol HandyJSONs: HandyJSON {
    
    /// 自定义属性映射关系,及解析路径
    ///  例：return [self.yx_name <-- "name",
    ///             self.yx_age <-- "data.age"]
    ///
    /// - Returns: return value description
    func yx_propertyMapper() -> [CustomMappingKeyValueTuple]?
    
    /// 序列化完成之后会执行，用于自定义更新
    func yx_update()
}

extension HandyJSONs {
    
    /// JSON反序列化
    ///
    /// - Parameters:
    ///   - dict: 类型为 NSDictionary || JsonString || [String: Any]
    ///   - designatedPath: 指定解析路径, 例："response.data.orderInfo" 表示解析 orderInfo字段下的数据
    /// - Returns: 数据model
    public static func yx_model(_ json: Any?, designatedPath: String? = nil) -> Self? {
        if (json is [String: Any]) || (json is NSDictionary) {
            return self.deserialize(from: json as? [String: Any], designatedPath: designatedPath)
        } else if json is String {
            return self.deserialize(from: json as? String, designatedPath: designatedPath)
        } else {
            return nil
        }
    }
    
    /// JSON转模型数组
    ///
    /// - Parameter array: 类型为 [NSDictionary] || JsonString || [[String: Any]]
    /// - Returns: model数组
    public static func yx_models(array: [Any]?) -> [Self]? {
        return array?.map({ (any) -> Self in
            return Self.yx_model(any) ?? Self()
        })
    }
    
    /// 更新model
    ///
    /// - Parameter jsonString: jsonString description
    public func yx_update(from json: Any?, designatedPath: String? = nil) {
        var object = self
        if (json is [String: Any]) || (json is NSDictionary) {
            JSONDeserializer.update(object: &object, from: json as? [String: Any], designatedPath: designatedPath)
        } else if json is String {
            JSONDeserializer.update(object: &object, from: json as? String, designatedPath: designatedPath)
        }
        yx_update()
    }
    
    public func didFinishMapping() {
        yx_update()
    }
    
    public func mapping(mapper: HelpingMapper) {
        let mapInfo = self.yx_propertyMapper()
        mapInfo?.forEach({ customMappingKeyValue in
            mapper <<< customMappingKeyValue
        })
    }
    
    /// 序列化
    ///
    /// - Returns: return value description
    public func yx_toJSON() -> [String : Any] {
        return self.toJSON() ?? [String : Any]()
    }
    
    /// 模型转json字符串
    /// - Returns: description
    public func yx_toJsonString() -> String? {
        return self.toJSONString()
    }
}

public extension Collection where Iterator.Element: HandyJSONs {
    
    /// 集合类型的模型反序列化
    ///
    /// - Returns: return value description
    func yx_toJSON() -> [[String: Any]] {
        return self.map{ ($0.toJSON() ?? [String: Any]()) }
    }
}

