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
        
        //코어데이터 전부다 삭제하고 싶을때
       /* let delegate = UIApplication.shared.delegate as! LPAppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        let deleteFetch1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let deleteRequest1 = NSBatchDeleteRequest(fetchRequest: deleteFetch1)
        
        do {
            try context.execute(deleteRequest)
            try context.execute(deleteRequest1)
            try context.save()
        } catch {
            print ("There was an error")
        }*/
    
        // 코어데이터 추가하고 싶을때
        /*
        for i in 1 ... 2 {
            let categoryModel: LPCategoryModel = LPCategoryModel(name: "햄버거 \(i)", r: 247, g: 0, b: 0, alpha: 1)
            if insertIntoCategory(valueCategory: categoryModel) {
                for j in 1 ... 10 {
                    let linkModel: LPLinkModel = LPLinkModel(url: "https://\(j)", title: "링크 타이틀\(j)", imageName: "\(j)", date: NSDate(), category: categoryModel)
                    insertIntoLink(valueLink: linkModel)
                }
            }
        }*/
        
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
