//
//  AlertUtil.swift
//  swift_demo
//
//  Created by JackLee on 2019/10/26.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

typealias AlertHandler = (() -> ())

class AlertUtil: NSObject {

    static func showPermissionWarining(vc: UIViewController, title: String?, message: String?, permitHandler: AlertHandler?, cancelHandler: AlertHandler?) {
        let alertCtrl = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let permitAction = UIAlertAction.init(title: "permit", style: UIAlertAction.Style.default) { (action) in
            permitHandler?()
        }
        let cancelAction = UIAlertAction.init(title: "cancel", style: UIAlertAction.Style.cancel) { (action) in
            cancelHandler?()
        }
        alertCtrl.addAction(permitAction)
        alertCtrl.addAction(cancelAction)
//        alertCtrl.show(vc, sender: nil)
//        alertCtrl.present(vc, animated: true, completion: {
//            print("alertCtrl completion")
//        })
        vc.present(alertCtrl, animated: true) {
            print("alertCtrl completion")
        }
    }
}
