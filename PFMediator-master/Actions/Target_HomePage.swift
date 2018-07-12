//
//  Target_HomePage.swift
//  PFMediator-master
//
//  Created by guo-pf on 2018/7/12.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

@objcMembers class Target_HomePage: NSObject {
    //方法名对应Api 中的 kMediatorActions 的值 加上 Action_
    func Action_HomePageMessageView(_ params: Dictionary<String, Any>?) -> UIViewController {
        let vc = HomePageMessageViewController()
        return vc
    }
    func Action_HomePageWeatherView(_ params: Dictionary<String, Any>?) -> UIViewController {
        let vc = HomePageWeatherViewController()
        return vc
    }
}
