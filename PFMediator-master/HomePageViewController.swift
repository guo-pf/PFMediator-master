//
//  HomePageViewController.swift
//  PFMediator-master
//
//  Created by guo-pf on 2018/7/12.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,PFMessageProtocol {
    
    
    @IBOutlet weak var myMessageLabel: UILabel!
    
    func getMessage(_ result: PFMessageProtocol.T?) {
        guard result != nil else{
            return
        }
         if result is UIColor {
            self.view.backgroundColor = (result as! UIColor)
        }
        if result  is String {
            self.myMessageLabel.text = (result as! String)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pushActionClicked(_ sender: Any) {
        let userInfo = UserModel(userName: "第一个人", userAge: 21, userSex: 0)
        let apiProvider = MediatorProvider<HomePageApi>()
        apiProvider.registered(targer: HomePageApi.homepage_Message(userInfo))
    }
    
    
    @IBAction func presentActionClicked(_ sender: Any) {
        let apiProvider = MediatorProvider<HomePageApi>()
        apiProvider.registered(targer: HomePageApi.homepage_weater)
        
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
