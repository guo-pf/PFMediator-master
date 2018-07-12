//
//  PFMediatorProvider.swift
//  GPFMediator
//
//  Created by guo-pf on 2018/5/29.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class MediatorProvider<Target:PFMediatorTargetType>{
    
}

extension MediatorProvider {
    public func registered(targer: Target){
        guard let vc = PFMediator.shared.performWith(targetName: targer.targetName,
                                                     actionName: targer.actionName,
                                                     params: nil,
                                                     shouldCacheTarget: targer.shouldCacheTarget) else{
                                                        return
        }
        PFRouter.open(vc as! UIViewController,
                    models: targer.params,
                    push: targer.type == .push ? true : false,
                    animated: targer.animated,
                    presentComplete: targer.presentComplete)

    }

}
