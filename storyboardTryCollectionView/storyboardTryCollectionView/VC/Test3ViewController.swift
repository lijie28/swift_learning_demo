//
//  Test3ViewController.swift
//  storyboardTryCollectionView
//
//  Created by JackLee on 2019/10/4.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class Test3ViewController: UIViewController {
    @IBOutlet weak var btnTest: UIButton!
    
    @IBAction func testBtn(_ sender: UIButton) {
    
        print("do sth hehe")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnTest.titleLabel?.text = "change"
        // Do any additional setup after loading the view.
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
