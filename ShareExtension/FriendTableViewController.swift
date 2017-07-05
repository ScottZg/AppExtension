//
//  FriendTableViewController.swift
//  ExtensionDemo
//
//  Created by zhanggui on 2017/7/4.
//  Copyright © 2017年 zhanggui. All rights reserved.
//

import UIKit


@objc(FriendTableViewControllerDelegate)
protocol FriendTableViewControllerDelegate {
    @objc optional func selectedFriendName(name: String)
}



class FriendTableViewController: UITableViewController {

    let tableViewCellIdentifier = "CellId"
    
    var delegate: FriendTableViewControllerDelegate?
    
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var contentArr: [String] = {
        let arr = ["张三","李四","王五","赵六","邢七"]
        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = contentArr[indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        if let theDelegate = delegate {
            theDelegate.selectedFriendName!(name: contentArr[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }

}
