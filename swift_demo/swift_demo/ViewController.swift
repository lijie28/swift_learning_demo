//
//  ViewController.swift
//  swift_demo
//
//  Created by JackLee on 2018/12/19.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建一个ContactAdd类型的按钮
        let button:UIButton = UIButton(type:.custom)
        button.backgroundColor = UIColor.yellow
        //设置按钮位置和大小
//        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        //设置按钮文字
        button.setTitle("按钮", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(button);
        button.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.center.equalToSuperview()
        }
        button.addTarget(self, action: <#Selector#> , for: UIControl.Event.touchUpInside)
    }


    func clickOnTheButton() ->
    {
        
    }
}

