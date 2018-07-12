//
//  Mediator.swift
//  PFMediator
//
//  Created by guo-pf on 2018/5/19.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import Foundation
import UIKit

public class mediatorModel {}

public class PFMediator {
    
    /// 单例
    public static let shared: PFMediator = {
        let instance = PFMediator()
        return instance
    }()
    
    /// 命名空间，namespace.target
    private var namespace : String
    
    /// target缓存
    private var targetCache : Dictionary<String, Any>
    
    /// 初始化
    private init() {
        namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        namespace = namespace.replacingOccurrences(of: "-", with: "_")
        targetCache = [String:Any]()
//        guard (namespace != nil) else {
//
//            return
//        }
    }
    
    ///  本地组件vararar用入口
    ///
    /// - Parameters:
    ///   - targetName: 调用的类名
    ///   - actionName: 调用的方法名
    ///   - params: 传递的参数
    ///   - shouldCacheTarget: 是否缓存Target实例
    /// - Returns: 返回值，如果没有返回值，则返回nil
    public func performWith(targetName: String, actionName: String, params: Dictionary<String,Any>? = nil, shouldCacheTarget: Bool) -> Any! {
        
        let targetString = "Target_\(targetName)"
        let actionString = "Action_\(actionName):"
        
        var target = targetCache[targetString] as? NSObject
        if target == nil {
            guard let targetClass = NSClassFromString("\(namespace).\(targetString)") as? NSObject.Type else {
                return nil
            }
            target = targetClass.init()
        }
        let action = NSSelectorFromString(actionString)
        if shouldCacheTarget {
            targetCache[targetString] = target
        }
        guard target!.responds(to: action) else {
            clearTargetCache(with: targetString)
            print("\(targetString)中没有找到方法:\(action)")
            return nil
        }
        let result = target!.perform(action, with: params)
        
        return result!.takeUnretainedValue()
    }
    
    /// 清除单个Target缓存
    ///
    /// - Parameter targetName: 调用的类名
    public func clearTargetCache(with targetName: String) {
        let targetString = "Target_\(targetName)"
        targetCache.removeValue(forKey: targetString)
    }
    
    /// 清除所有Target缓存
    public func clearTargetCacheWithAll() {
        targetCache.removeAll()
    }

}

