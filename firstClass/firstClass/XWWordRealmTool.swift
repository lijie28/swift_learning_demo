//
//  XWWordRealmTool.swift
//  firstClass
//
//  Created by JackLee on 2019/4/13.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import RealmSwift

class XWWordRealmTool: Object {
    private class func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
    
    
}

/// 增
extension XWWordRealmTool {
    
    /// 获取 所保存的 Student
    public class func getDictWords() -> Results<DictWord> {
        let defaultRealm = self.getDB()
        return defaultRealm.objects(DictWord.self)
    }
    
    
    public class func insertWord(by word : DictWord) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(word)
        }
        //        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    public class func addDatas(by datas :NSArray) -> Void{
        
        for d  in datas
        {
            let dicWord  = d as! NSDictionary
            let word = DictWord()
            word.key = dicWord["key"] as! String
            word.describe = dicWord["describe"] as! String
            word.explain = dicWord["explain"] as! String
            word.pronounce = dicWord["pronounce"] as! String
            word.name = dicWord["name"] as! String
            word.url = dicWord["url"] as! String
            self.insertWord(by: word)
        }
    }
    
}
