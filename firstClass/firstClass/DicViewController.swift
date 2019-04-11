//
//  DicViewController.swift
//  firstClass
//
//  Created by JackLee on 2019/2/15.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class DicViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:
            UITableViewCell.CellStyle.subtitle, reuseIdentifier: "ResultCell")
        cell.textLabel!.text = "Cell text"
        cell.detailTextLabel?.text = "Cell Subtitle"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init() 
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "no words")
        let rvc = InitStoryboardViewController(identifier: "resultSB") as! ResultViewController
        rvc.keyword = searchBar.text ?? "no result"
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    


}
