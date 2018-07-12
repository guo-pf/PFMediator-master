//
//  Mediator_HomePageApi.swift
//  PFMediator-master
//
//  Created by guo-pf on 2018/7/12.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

   private struct kMediatorTargets{
        static let kMediatorTargetHomePage  =   "HomePage"
    }
   private struct kMediatorActions{
        //       这个对应Tager的方法名 去掉 Action_前缀
        static let kMediatorActionHomePageMessage  =   "HomePageMessageView"
        static let kMediatorActionHomePageWeather  =   "HomePageWeatherView"
    }

//这是定义几个跳转页面的接口
enum HomePageApi {
    case homepage_Message(Any) //有传入的值的
    case homepage_weater //无传入值的
}

//遵循PFMediatorTargetType协议 进行配置
extension HomePageApi: PFMediatorTargetType {
    var type: methodType {
        switch self {
        case .homepage_Message(_):
            return .push
        case .homepage_weater:
            return .present
        }
    }
    
    var animated: Bool {
        return true
    }
    
    var targetName: String{
        return kMediatorTargets.kMediatorTargetHomePage
    }
    
    var actionName: String{
        switch self {
        case .homepage_Message(_):
            return kMediatorActions.kMediatorActionHomePageMessage
        case .homepage_weater:
            return kMediatorActions.kMediatorActionHomePageWeather
        }
    }
    var params: Any? {
        switch self {
        case .homepage_Message(let model):
            return model
        case .homepage_weater:
            return nil
        }
    }
    var shouldCacheTarget: Bool {
        switch self {
        case .homepage_Message:
            return false
        case .homepage_weater:
            return false
        }
    }
    
    
    
}
