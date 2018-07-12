//
//  PFMediatorTargetType.swift
//  GPFMediator
//
//  Created by guo-pf on 2018/5/28.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

public protocol PFMediatorTargetType {
    
    var targetName: String { get }
    var actionName: String { get }
    var params: Any? { get }
    var shouldCacheTarget : Bool { get }
    var type : methodType { get }
    var animated : Bool { get }
    var presentComplete : (()->Void)? { get }
   // push: Bool = true , animated: Bool = true , presentComplete: (()->Void)? = nil
    
}
public enum methodType {
    case push
    case present
}


public extension PFMediatorTargetType {
    
    var shouldCacheTarget: Bool {
        return false
    }
    var params : Any?{
        return nil
    }
    var animated: Bool {
        return true
    }
    var presentComplete : (()->Void)? {
        return nil
    }
}


