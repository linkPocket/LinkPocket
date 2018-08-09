//
//  LPCategoryViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData

class LPCategoryViewController: UIViewController, LPCoreDataManager {

    var mCategoryV: LPCategoryV!
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pasteboard = UIPasteboard.general
        if let string = pasteboard.string {
            if string.isValidURL {
                print("\(string) is url")
            } else {
                print("\(string) is not url")
            }
        }
        
        urls = selectAllObjectFromLink() as! [LPLinkModel]
        categorys = selectAllObjectFromCategory() as! [LPCategoryModel]
        
        mCategoryV = LPCategoryV(frame: R(0,0,W,H-statusH), categorys: categorys, urls: urls)
        self.view.addSubview(mCategoryV)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
