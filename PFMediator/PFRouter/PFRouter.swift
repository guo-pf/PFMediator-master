//
//  Router.swift
//  GPFMediator
//
//  Created by guo-pf on 2018/5/20.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit


public class PFRouterUtils {
    //获取当前页面
    public class func currentTopViewController() -> UIViewController? {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
            let viewController : UIViewController = currentTopViewController(rootViewController: rootViewController)
            return viewController
        }else{
            return nil
        }
    }
    public class func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
        if (rootViewController.isKind(of: UITabBarController.self)) {
            let tabBarController = rootViewController as! UITabBarController
            let viewController : UIViewController = currentTopViewController(rootViewController: tabBarController.selectedViewController!)
            return viewController
        }
        if (rootViewController.isKind(of: UINavigationController.self)) {
            let navigationController = rootViewController as! UINavigationController
            let viewController : UIViewController = currentTopViewController(rootViewController: navigationController.visibleViewController!)
            return viewController
        }
        if ((rootViewController.presentedViewController) != nil) {
            let viewController : UIViewController = currentTopViewController(rootViewController: rootViewController.presentedViewController!)
            return viewController
        }
      // print(rootViewController)
        return rootViewController
    }
}

extension PFRouter{
    //防止用户选择错误，出现错误，如果退出失败，会自动切换判断是pop 还是dismiss
    final class func dismissVC(_ toVC:UIViewController , models: T? = nil, animated: Bool = true , presentComplete:(()->Void)? = nil) -> Bool{
        let vcArray = toVC.presentingViewController?.childViewControllers
        guard vcArray != nil else {
         //  pop(models, pop: true, animated: animated, presentComplete: presentComplete)
            return false
        }
        guard (vcArray?.count)! > 0 else{
            return false
        }
        let superVC = vcArray?.last
        if (superVC?.isKind(of: UIViewController.self))! && models != nil{
            sendMessage(superVC!, message: models!)
        }
        toVC.dismiss(animated: animated, completion: presentComplete)
        return true
    }
    final class func popVC(_ toVC:UIViewController , models: T? = nil, animated: Bool = true , presentComplete:(()->Void)? = nil)  -> Bool{
        let vcArray = toVC.navigationController?.viewControllers
        guard vcArray != nil else {
         //   pop(models, pop: false, animated: animated, presentComplete: presentComplete)
            return false
        }
        guard (vcArray?.count)! > 0 else{
            return false
        }
        let index : Int = (vcArray?.index(of: toVC))!
        guard index > 0 else {
            return false
        }
        let vc = vcArray![index-1]
        if (vc.isKind(of: UIViewController.self)) && models != nil{
            sendMessage(vc, message: models!)
        }
        toVC.navigationController?.popViewController(animated: animated)
        return true
    }
    final class func sendMessage(_ vc:UIViewController , message : T){
        let strClass : AnyClass = object_getClass(vc)!
        guard strClass !=  Optional.none else {
            return
        }
        guard class_conformsToProtocol(strClass, PFMessageProtocol.self) else{
            return
        }
        let actionString = "getMessage:"
        let action = NSSelectorFromString(actionString)
        guard vc.responds(to: action) else{
            return
        }
        vc.perform(action, with: message)
        return
    }
}

open class PFRouter<T> {
    //先pop再Push
    open class func openPopAfterPush(_ vc : UIViewController , models: T? = nil, animated: Bool = true){
      //   vc.hidesBottomBarWhenPushed = true
        let topViewController = PFRouterUtils.currentTopViewController()
        
        var vcArray = topViewController?.navigationController?.viewControllers
        guard vcArray != nil else{
            return
        }
        guard (vcArray?.count)! > 0 else{
            print("***********************之前不是push进来的吧？***********************")
            return
        }
        let index : Int = (vcArray?.index(of: topViewController!))!
        guard index > 0 && index < (vcArray?.count)! else{
            return
        }
        vcArray?.remove(at: index)
        vcArray?.append(vc)
        guard vc.isKind(of: UIViewController.self) else{
            return
        }
        if  models != nil {
            sendMessage(vc, message: models!)
        }
        topViewController?.navigationController?.setViewControllers(vcArray!, animated: animated)
    }

    open class func open(_ vc:UIViewController , models: T? = Optional.none, push: Bool = true , animated: Bool = true , presentComplete: (()->Void)? = nil){
        
        let topViewController = PFRouterUtils.currentTopViewController()
        topViewController?.hidesBottomBarWhenPushed = true
        guard vc.isKind(of: UIViewController.self) else{
            return
        }
        if  models != nil {
            sendMessage(vc, message: models!)
        }
        if topViewController?.navigationController != nil && push {
            
            topViewController?.navigationController?.pushViewController(vc, animated: animated)
        }else{
            topViewController?.present(vc, animated: animated , completion: presentComplete)
        }
    }
    
    open class func pop(_ models: T? = nil, pop: Bool = true, animated: Bool = true , presentComplete:(()->Void)? = nil){
        let topViewController = PFRouterUtils.currentTopViewController()
        guard (topViewController?.isKind(of: UIViewController.self))! else{
            return
        }
        if !pop {
          let isSuccess = dismissVC(topViewController!, models: models, animated: animated, presentComplete: presentComplete)
            guard isSuccess == false else {
                return
            }
            print("***********************该页面不是present进来的吧？***********************")
             let _ = popVC(topViewController!, models: models, animated: animated, presentComplete: presentComplete)
        }else{
            let isSuccess = popVC(topViewController!, models: models, animated: animated, presentComplete: presentComplete)
            guard isSuccess == false else {
                return
            }
             print("***********************该页面不是push进来的吧？***********************")
              let _ = dismissVC(topViewController!, models: models, animated: animated, presentComplete: presentComplete)
        }
    }
    
}

