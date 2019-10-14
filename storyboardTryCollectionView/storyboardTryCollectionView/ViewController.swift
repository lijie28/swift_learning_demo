//
//  ViewController.swift
//  storyboardTryCollectionView
//
//  Created by JackLee on 2019/10/4.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    

    //
    
    // 获取sb
    let MainSB = UIStoryboard.init(name: "Main", bundle: nil)
    let testSB = UIStoryboard.init(name: "test", bundle: nil)
    
    private func InitStoryboardViewController(identifier:String) -> UIViewController {
        return MainSB.instantiateViewController(withIdentifier: identifier)
    }
    
    @IBOutlet weak var collection: UICollectionView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    private var selectedIndex = 0
    
    private let screen_width:CGFloat = UIScreen.main.bounds.size.width
    private let screen_height:CGFloat = UIScreen.main.bounds.size.height
    
    var titles = ["haalle","sdfwef","asdfawefefe","sdf","qweqwefqwef","zxcvqweq","hrttyjc","asdfqwevterre","ddww","dfeex",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("go")
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        scrollView.contentSize = CGSize(width: screen_width * CGFloat(titles.count), height: 0)
        
        let test1 = Test3ViewController()
        test1.view.frame = CGRect(x: 0, y: 0, width: screen_width , height: screen_height)
        
        
        let test2 = InitStoryboardViewController(identifier: "test2") as! Test2ViewController
        test2.view.frame = CGRect(x: screen_width, y: 0, width: screen_width , height: screen_height)
        
        
        let test3 = testSB.instantiateViewController(withIdentifier: "test3") as! Test3ViewController
        test3.view.frame = CGRect(x: screen_width*2, y: 0, width: screen_width , height: screen_height)
        
        scrollView.addSubview(test1.view)
        scrollView.addSubview(test2.view)
        scrollView.addSubview(test3.view)
        
        scrollView.isPagingEnabled = true
    }
    
    


}

extension ViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        print(scrollView.contentOffset)
        
        selectedIndex = Int(scrollView.contentOffset.x / screen_width)
        self.collection.reloadData()
        
        self.collection.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
            as! MyCollectionViewCell

        cell.label.text = titles[indexPath.row]
        
        if indexPath.row == selectedIndex{
            
            cell.backgroundColor = UIColor.yellow
        }else{
            
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.collection.reloadData()
        
        self.scrollView.setContentOffset(CGPoint(x: screen_width * CGFloat(selectedIndex), y: 0), animated: true)
        
        self.collection.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
    }

}

