//
//  HomePageMessageViewController.swift
//  PFMediator-master
//
//  Created by guo-pf on 2018/7/12.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class HomePageMessageViewController: UIViewController,PFMessageProtocol{
    func getMessage(_ result: PFMessageProtocol.T?) {
        print("message: \(result as Any)")
    }
    
    //页面跳转3
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let str  = randomStr()
        PFRouter.pop(str, pop: true, animated: true, presentComplete: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
    }

    func randomStr() -> String {
        let one = arc4random()%100
        let two = arc4random()%100 + 500
        let three = arc4random()%100 + 10000
        return String(one+two+three)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
