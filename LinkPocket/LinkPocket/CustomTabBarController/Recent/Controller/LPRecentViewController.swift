//
//  LPRecentViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData

class LPRecentViewController: UIViewController, LPCoreDataManager {

    var mLPRecentView: LPRecentView!
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urls = selectAllObjectFromLink() as! [LPLinkModel]
        categorys = selectAllObjectFromCategory() as! [LPCategoryModel]
        
        mLPRecentView = LPRecentView(frame: R(0,0,W,H), urls: urls)
        self.view.addSubview(mLPRecentView)
        
//        let delegate = UIApplication.shared.delegate as! LPAppDelegate
//        let context = delegate.persistentContainer.viewContext
//
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch {
//            print ("There was an error")
//        }
//
        
        
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Link")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
//
//        do {
//            try (UIApplication.shared.delegate as! LPAppDelegate).persistentContainer.viewContext.execute(deleteRequest)
//            try (UIApplication.shared.delegate as! LPAppDelegate).persistentContainer.viewContext.save()
//        } catch {
//            print ("There was an error")
//        }
//
//
//        for i in 1 ... 4 {
//            let categoryModel: LPCategoryModel = LPCategoryModel(name: "피자 \(i)", r: 55, g: 88, b: 97, alpha: 1)
//            insertIntoCategory(valueCategory: categoryModel)
//            for j in 1 ... 10 {
//                let linkModel: LPLinkModel = LPLinkModel(url: "https://\(j + (i - 1) * 10)", title: "링크 타이틀\(j)", imageName: "\(j)", date: NSDate(), category: categoryModel)
//                insertIntoLink(valueLink: linkModel)
//            }
//        }
//
//        let links = selectAllObjectFromLink() as? [LPLinkModel]
//        for link in links! {
//            link.printLinks()
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
