//
//  UserModel.swift
//  PFMediator-master
//
//  Created by guo-pf on 2018/7/12.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var userName:String?
    var userAge:Int = 0
    var userSex:Int = 0
    init(userName:String? = nil ,userAge:Int? = 0,userSex:Int? = 0) {
        self.userName = userName
        self.userAge = userAge!
        self.userSex = userSex!
    }
}
