//
//  YXSwiftModel_OC.swift
//  Taoyuejia
//
//  Created by zxw on 2021/2/26.
//  Copyright © 2020 zxw. All rights reserved.
//  HandyJSON 中间件

import UIKit
import HandyJSON

open class YXSwiftModel_OC: NSObject, HandyJSONs {
    
    required public override init() {
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

