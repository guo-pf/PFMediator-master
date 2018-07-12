//
//  MessageProtocol.swift
//  GPFMediator
//
//  Created by guo-pf on 2018/5/21.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

@objc protocol PFMessageProtocol {
    typealias T = Any
    func getMessage(_ result : T?)
 //  @objc optional  var parseData : ResultData {get}

}
