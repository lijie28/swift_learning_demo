//
//  DictWord.swift
//  firstClass
//
//  Created by JackLee on 2019/4/2.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import RealmSwift


class DictWord: Object {
    @objc dynamic var describe = ""
    @objc dynamic var explain = ""
    @objc dynamic var key = ""
    @objc dynamic var name = ""
    @objc dynamic var pronounce = ""
    @objc dynamic var url = ""
    @objc dynamic var id = NSUUID().uuidString
    
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    /**
    //重写 Object.primaryKey() 可以设置模型的主键。
    //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
    //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。
    let books = List<Book>()
 */
}
