//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by zhanggui on 2017/7/4.
//  Copyright © 2017年 zhanggui. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
class ShareViewController: SLComposeServiceViewController,FriendTableViewControllerDelegate {

    let suitName = "group.com.shuqu.shareExtension"
    let imageKey = "ImageKey"
    var selectedFriend = "Default"
    /// 用来检查内容是否符合应用的使用
    ///
    /// - Returns: yes表示符合，no表示不符合
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
            let contentType = kUTTypeImage as String
            
            if let contents = content.attachments as? [NSItemProvider] {
                for attach in contents {
                    if attach.hasItemConformingToTypeIdentifier(contentType) {
                        attach.loadItem(forTypeIdentifier: contentType, options: nil, completionHandler: { (data, error) in
                            let url = data as! URL
                            if let imageData = try? Data.init(contentsOf: url) {
                                if let prefs = UserDefaults.init(suiteName: self.suitName) {
                                    prefs.set(imageData, forKey: self.imageKey)
                                }
                            }
                        })
                    }
                }
            }
        }
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [friendConfig]
    }
    lazy var friendConfig: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem.init()
        item?.title = "发送给朋友"
        item?.value = "请选择"
        item?.tapHandler = self.showSelectedVC
        
        
        return item!
    }()
    
    
    
    func showSelectedVC() {
        let controller = FriendTableViewController.init(style: .plain)
        controller.delegate = self
        pushConfigurationViewController(controller)
    }
    func selectedFriendName(name: String) {
        friendConfig.value = name
        selectedFriend = name
    }

}
