//
//  Test2ViewController.swift
//  storyboardTryCollectionView
//
//  Created by JackLee on 2019/10/4.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit


protocol Test2ViewControllerInput {
    func doSth()
}

protocol Test2ViewControllerOutput {
    func saySth(word:String)
}


class Test2ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    
//    var output : Test2ViewControllerOutput
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("test2 load")
        let tf = UILabel()
        tf.frame = CGRect(x: 0, y: 0, width: 100, height: 50 )
        tf.text = "test"
        
        let tbtn = UIButton()
        tbtn.frame = CGRect(x: 100, y: 50, width: 100, height: 50 )
        tbtn.backgroundColor = UIColor.yellow
//        tbtn.text = "test"
        self.view.addSubview(tbtn)
        tbtn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
//        tbtn.addSubview(tf)
        btn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    

    
    @objc func btnClick(sender: UIButton) {
        
    }
//    @objc func doSth()  {
//        print("hehe")
//    }
    
}

extension Test2ViewController : Test2ViewControllerInput{
    
    
    func doSth() {
        print("123456")
    }
    
    
}
