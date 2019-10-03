//
//  Test2ViewController.swift
//  storyboardTryCollectionView
//
//  Created by JackLee on 2019/10/4.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("test2 load")
        let tf = UILabel()
        tf.frame = CGRect(x: 0, y: 0, width: 100, height: 50 )
        tf.text = "test"
        self.view.addSubview(tf)
        
        btn.addTarget(self, action: #selector(doSth), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    

    @objc func doSth()  {
        print("hehe")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
