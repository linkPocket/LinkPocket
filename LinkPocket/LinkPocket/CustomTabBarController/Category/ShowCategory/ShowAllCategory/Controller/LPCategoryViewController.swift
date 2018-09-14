//
//  LPCategoryViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData

class LPCategoryViewController: UIViewController, LPCategoryVListener {

    var mCategoryV: LPCategoryView!
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
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        if let mLPRecentView = Bundle.main.loadNibNamed("LPCategoryView", owner: self, options: nil)?.first as? LPCategoryView {
            mCategoryV = mLPRecentView
            self.view.addSubview(mCategoryV)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startWriteCategory() {
        print("카테고리를 추가해주세요")
    }
    
    func refreshData(urls: [LPLinkModel], categorys: [LPCategoryModel]) {
        mCategoryV.urls = urls
        mCategoryV.urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        mCategoryV.tableItems = LPGroupingTable(urls: urls)
        
        mCategoryV.mLPCategoryList.reloadData()
        
        print("Hello")
    }
    
    func test() {
        print("돼라돼라 얍")
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
