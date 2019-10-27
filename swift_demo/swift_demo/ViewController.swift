//
//  ViewController.swift
//  swift_demo
//
//  Created by JackLee on 2018/12/19.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit
//import SnapKit
import FileProvider
//import FileBrowser


class ViewController: UIViewController {
    
    var permissionUtil: PermissionUtil?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = R.color.bgColor()
        self.permissionUtil = PermissionUtil()
        self.testCheckBluetoothPermission()
        
        /// NotificationCenterを登録
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(notification:)), name: .applicationDidEnterBackground, object: nil)
        
//        R.storyboard.
    }
    
    @objc func applicationDidEnterBackground(notification: Notification) {
//        self.permissionUtil = nil
    }
    
    func openSystemSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            // Handling errors that should not happen here
            return
        }
        let app = UIApplication.shared
        app.open(url)
    }
    
    func testCheckBluetoothPermission() {
        
        self.permissionUtil?.checkBluetooth { [weak self] (isOk) in
            if isOk {
                print("ok")
            }
            else {
                print("ng")
                guard let vc = self else { return }
                AlertUtil.showPermissionWarining(vc: vc, title: "notice", message: "check bluetooth please", permitHandler: { [weak self] in
                    self?.openSystemSetting()
                }, cancelHandler: nil)
            }
        }
    }
    
    func testSandBox() {
        //https://www.hangge.com/blog/cache/detail_527.html
        
        //step6. 获取沙盒里所有文件
        let fileManager = FileManager.default
        //在这里获取应用程序Documents文件夹里的文件及文件夹列表
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDir = documentPaths.first
        //        NSError *error = nil;
        
        documentPaths.forEach { (path) in
            print("path:",path)
        }
        
        //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
        //        let fileList = fileManager.contents(atPath: documentDir)
        
        
        do {
            let fileList = try fileManager.contentsOfDirectory(atPath: documentDir!)
            
            print("沙盒：%@",documentPaths ,fileList)
        } catch {
            // エラー処理
        }
    }
    
    @IBAction func clickOnSelectFile(_ sender: Any) {
        self.testCheckBluetoothPermission()
    }
}

