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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        

        
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDir = documentPaths.first
//
//        let fileP = NSFileProviderManager.init(for: NSFileProviderManage)
//        self.show(fileP, sender: nil)
////        let fileBrowser = FileBrowser(initialPath: documentDir)
//        let browser = UIDocumentBrowserViewController(forOpeningFilesWithContentTypes: ["public.plain-text"])
//        browser.importDocument(at: URL(string: documentDir!)!, nextToDocumentAt: URL(string: documentDir!)!, mode: UIDocumentBrowserViewController.ImportMode.copy) { (url, error) in
//            //https://developer.apple.com/documentation/uikit/uidocumentbrowserviewcontroller
//
//            //https://github.com/marmelroy/FileBrowser
//
//            print(url,error)
//        }
//        self.show(browser, sender: nil)
    }
}













//        //创建一个ContactAdd类型的按钮
//        let button:UIButton = UIButton(type:.custom)
//        button.backgroundColor = UIColor.yellow
//        //设置按钮位置和大小
////        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
//        //设置按钮文字
//        button.setTitle("按钮", for: UIControl.State.normal)
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        self.view.addSubview(button);
//        button.snp.makeConstraints { (make) in
//            make.width.equalTo(100)
//            make.height.equalTo(100)
//            make.center.equalToSuperview()
//        }
//        button.addTarget(self, action: <#Selector#> , for: UIControl.Event.touchUpInside)



