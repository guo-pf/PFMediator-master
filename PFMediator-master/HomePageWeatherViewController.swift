//
//  HomePageWeatherViewController.swift
//  PFMediator-master
//
//  Created by guo-pf on 2018/7/12.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class HomePageWeatherViewController: UIViewController,PFMessageProtocol {
    func getMessage(_ result: PFMessageProtocol.T?) {
        print("weater \(result as Any)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = randomColor()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        PFRouter.pop(self.view.backgroundColor, pop: false, animated: true, presentComplete: nil)
    }
    
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
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
