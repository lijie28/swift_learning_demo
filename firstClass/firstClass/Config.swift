//
//  Config.swift
//  firstClass
//
//  Created by JackLee on 2019/2/16.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
// 获取sb
let MainSB = UIStoryboard.init(name: "Main", bundle: nil)
// 实例化sb 的vc
func InitStoryboardViewController(identifier:String) -> UIViewController {
    return MainSB.instantiateViewController(withIdentifier: identifier)
}

//class Config: NSObject {
//
//}
