
//
//  ResultViewController.swift
//  firstClass
//
//  Created by JackLee on 2019/2/16.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import Alamofire
//import libxml2

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
    
    public class func insertWord(by word : DictWord) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(word)
        }
//        print(defaultRealm.configuration.fileURL ?? "")
    }
}


class ResultViewController: UIViewController {
    var keyword = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = keyword
        
        self.sendRequestToLoadDetail(keyword: keyword)
        
    }

    
    
    func sendRequestToLoadDetail(keyword:String) {
        
        //接口路径
        let path = "https://dict.hjenglish.com/jp/jc/" as String
        
        //路径-+参数
        let pathWithKeyword = path + keyword  as String
        
        //encode
        let encodeStr = pathWithKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let head = ["User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36",
                    "Cookie":"HJ_UID=6593b0b2-7ac5-a9ac-d609-4fa885919f7a;HJ_CST=1;HJ_SID=9bcae955-1ba1-8a00-30da-39af2b4b76e3;_REF=;TRACKSITEMAP=3%2C;HJ_SSID_3=c64a2247-2bad-95bf-a3fa-cf855a6baec3;HJ_CSST_3=1;_SREF_3="]
        
        
        Alamofire.request(encodeStr!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: head).validate(contentType: ["text/html"]).responseString { (DataResponse) in
            
            if (DataResponse.error == nil)
            {
//                print("成功：",DataResponse)
                let result = self.matchKeyword(data: DataResponse.data!, keyword: keyword ) as NSDictionary
                print("result:",result["datas"] ?? "no result")
                
                let datas = result["datas"] as! NSArray
                let dicWord = datas[0] as! NSDictionary
                
                let word = DictWord()
                word.key = dicWord["key"] as! String
                word.describe = dicWord["describe"] as! String
                word.explain = dicWord["explain"] as! String
                word.pronounce = dicWord["pronounce"] as! String
                word.name = dicWord["name"] as! String
                word.url = dicWord["url"] as! String
                
                XWWordRealmTool.insertWord(by: word)
                
//                print(Realm.Configuration.fileURL ?? "")
            }
            else{
                print("出错",DataResponse.error as Any)
            }
        }
        
        print("get \(keyword)")
    }

    
    
    func matchKeyword(data:Data, keyword:String) -> Dictionary<String, Any> {
        var mudic = Dictionary<String,Any>()
        var muarr = Array<Any>()
      
        let xpathParser = TFHpple.init(htmlData: data as Data) as TFHpple
        
        let all_a = xpathParser.search(withXPathQuery: "//div[@class='pronounces']") as NSArray
        let all_b = xpathParser.search(withXPathQuery: "//div[@class='simple']") as NSArray
        let all_n = xpathParser.search(withXPathQuery: "//div[@class='word-text']") as NSArray
        let all_r = xpathParser.search(withXPathQuery: "//p[@class='redirection']") as NSArray
        
        if (all_r.count>0){
            let ele = all_r[0] as! TFHppleElement
            let redirections = self.rematch(string: ele.raw , strFront: "<p class=\"redirection\">", strBack: "</p>")
            let redirection = redirections.joined (separator: " ")
            mudic.updateValue(redirection, forKey: "redirection") // 如果key不存在，则添加新元素
            print(redirection)
        }
        
        let all_c = NSMutableArray.init()
        all_a.enumerateObjects { (obj, i, UnsafeMutablePointer) in
            let eleA = obj as! TFHppleElement;
            if eleA.raw.contains("word-audio"){
                all_c.addObjects(from: [obj])
            }
        }
        
        
        all_c.enumerateObjects { (obj, i, UnsafeMutablePointer) in

            let eleA = all_c[i] as! TFHppleElement
            let eleB = all_b[i] as! TFHppleElement
            let eleN = all_n[i] as! TFHppleElement
            
//            print("\(i):",eleA.raw,eleB.raw,eleN.raw)
            
            let names = self.rematch(string: eleN.raw , strFront: "<h2>", strBack: "</h2>") as NSArray
            let name = names.componentsJoined(by: "")
            if mudic["redirection"] != nil
            {
                mudic["research"] = name;
            }
            
            let pronounces = self.rematch(string: eleA.raw , strFront: "<span>", strBack: "</span>") as NSArray
            let pronounce = pronounces.componentsJoined(by: " ")
            
            let describes = self.rematch(string: eleB.raw , strFront: "<h2>", strBack: "</h2>") as NSArray
            let describe = describes.componentsJoined(by: "")
            
            let explains = self.rematch(string: eleB.raw , strFront: "</span>", strBack: "</li>") as NSArray
            var explain = ""
            
            explains.enumerateObjects({ (obj, i, UnsafeMutablePointer) in
                if (i==0) {
                    explain = "\(explain)\(i+1).\(explains[i])"
                }else{
                    explain = "\(explain)\n\(i+1).\(explains[i])"
                }
            })
            
            let m4vurls = self.rematch(string: eleA.raw , strFront: "data-src=\"", strBack: "\"") as NSArray
//            NSArray *m4vurls = [self match:eleA.raw front:@"data-src=\"" back:@"\""];
            var url = ""
            if (m4vurls.count==1) {
                url = m4vurls[0] as! String
            }
            //        NSString *key =
            //        NSLog(@"当前时间：%@",[self getNowTimeTimestamp]);
            
            muarr.append ([
                "pronounce":pronounce,
                "describe":describe,
                "explain":explain,
                //                "time":[self getNowTimeTimestamp],
                "url":url,
                "name":name,
                "key":"\(name)\(pronounce)",
                ])
            
//            print("detail:",name,",",pronounce,",",describe,",",explain)
//            print("detail:",muarr)
        }
        mudic.updateValue(muarr, forKey: "datas")
        return mudic
    }
    
    func rematch(string:String,strFront:String,strBack:String) -> Array<String> {
        
//        let regex = "\(strFront).\(strBack)"
        
        let regex = strFront+".*"+strBack
        
        let regular = try? NSRegularExpression.init(pattern: regex, options: NSRegularExpression.Options.caseInsensitive ) as NSRegularExpression
        
        let matches:Array = regular!.matches(in: string as String, options: [], range:  NSMakeRange(0, string.count ))
        
        
        var tmp = Array<String>()
    
        for m in matches {
            
            let match = m
            let range = match.range
            let nstring = string as NSString
            var mstr:NSString = nstring.substring(with: range) as NSString
            mstr = mstr.replacingOccurrences(of: "\(strFront)", with: "") as NSString
            mstr = mstr.replacingOccurrences(of: "\(strBack)", with: "") as NSString
            tmp.append(mstr as String)
            
            
        }
        return tmp
    }
}
