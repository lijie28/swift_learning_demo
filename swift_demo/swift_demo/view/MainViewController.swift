//
//  MainViewController.swift
//  swift_demo
//
//  Created by JackLee on 2019/11/4.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOnCoolMode(_ sender: Any) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    @IBAction func clickOnHeatMode(_ sender: Any) {
        
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
    }
}
