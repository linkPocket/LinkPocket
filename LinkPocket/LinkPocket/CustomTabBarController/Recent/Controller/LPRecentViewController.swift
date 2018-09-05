//
//  LPRecentViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData

class LPRecentViewController: UIViewController {

    var mLPRecentView: LPRecentView!
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//                let delegate = UIApplication.shared.delegate as! LPAppDelegate
//                let context = delegate.persistentContainer.viewContext
//
//                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
//                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//                do {
//                    try context.execute(deleteRequest)
//                    try context.save()
//                } catch {
//                    print ("There was an error")
//                }
//
//
//
//        
//    
//                    var categoryModel = LPCategoryModel()
//                    categoryModel.name = "Movie2"
//                    categoryModel.setRGBA(color: .red)
//        
//                    LPCoreDataManager.store.insertIntoCategory(valueCategory: categoryModel)
//                    for j in 1 ... 10 {
//                        let linkModel: LPLinkModel = LPLinkModel(url: "https://a\(j)", title: "Musica\(j)", imageName: "\(j)", date: NSDate(), category: categoryModel)
//                        LPCoreDataManager.store.insertIntoLink(valueLink: linkModel)
//                    }
//        
//                let links = LPCoreDataManager.store.selectAllObjectFromLink() as? [LPLinkModel]
//                for link in links! {
//                    link.printLinks()
//                }
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        if let mLPRecentView = Bundle.main.loadNibNamed("LPRecentView", owner: self, options: nil)?.first as? LPRecentView {
            self.view.addSubview(mLPRecentView)
        }

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
