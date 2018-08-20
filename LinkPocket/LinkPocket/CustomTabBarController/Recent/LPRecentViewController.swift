//
//  LPRecentViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData

struct test {
    var name: String
    var color: String
}

class LPRecentViewController: UIViewController {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
//
//        do {
//            try (UIApplication.shared.delegate as! LPAppDelegate).persistentContainer.viewContext.execute(deleteRequest)
//            try (UIApplication.shared.delegate as! LPAppDelegate).persistentContainer.viewContext.save()
//        } catch {
//            print ("There was an error")
//        }
//        for i in 1 ... 4 {
//            let categoryModel: LPCategoryModel = LPCategoryModel(name: "햄버거 \(i)", r: 0, g: 0, b: 0, alpha: 0)
//            insertIntoCategory(valueCategory: categoryModel)
//        }
        
//
//        for i in 1 ... 4 {
//            let categoryModel: LPCategoryModel = LPCategoryModel(name: "햄버거 \(i)", r: 0, g: 0, b: 0, alpha: 0)
//            insertIntoCategory(valueCategory: categoryModel)
//            for j in 1 ... 10 {
//                let linkModel: LPLinkModel = LPLinkModel(url: "https://\(j + (i - 1) * 10)", title: "링크 타이틀\(j)", imageName: "\(j)", date: NSDate(), category: categoryModel)
//                insertIntoLink(valueLink: linkModel)
//            }
//        }
        
        let store = LPCoreDataManager.store
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)

        do {
            try store.persistentContainer.viewContext.execute(deleteRequest)
            try store.persistentContainer.viewContext.save()
        } catch {
            print ("There was an error")
        }
        for i in 1 ... 4 {
            let categoryModel: LPCategoryModel = LPCategoryModel(name: "햄버거 \(i)", r: 0, g: 0, b: 0, alpha: 0)
            store.insertIntoCategory(valueCategory: categoryModel)
        }

//        let defaults = UserDefaults(suiteName: "group.CoreDataTest2")
//        var resultArr = [String]()
//        for category in categorys! {
//            resultArr.append(category.name!)
//        }
//        defaults?.set(resultArr, forKey: "category")
//        defaults?.synchronize()
//
//        var checkLink: LPLinkModel?
//        if let checks = defaults?.object(forKey: "link") as? [[String: String]] {
//            print("checks count : \(checks.count)")
//            if let check = checks.first {
//                checkLink = LPLinkModel()
//                if let name = check["category"] {
//                    checkLink?.category = selectObjectFromCategoryWhere(nameIs: name)
//                }
//                checkLink?.title = check["title"]
//                checkLink?.url = check["url"]
//                checkLink?.date = NSDate()
//                checkLink?.imageName = check["imageName"]
//            }
//        }
//
//        if let link = checkLink {
//            if insertIntoLink(valueLink: link) {
//                print("[info] .... check share extension and insert link seuccessfully")
//            }
//            defaults?.removeObject(forKey: "link")
//            defaults?.synchronize()
//        }
//
//        let links = selectAllObjectFromLink() as? [LPLinkModel]
//        for link in links! {
//            link.printLinks()
//
//
//            let documentsURL = URL(string: link.imageName!)
//
//            let filePath = documentsURL?.path
//            if FileManager.default.fileExists(atPath: filePath!) {
//                self.previewImage.image = UIImage(contentsOfFile: filePath!)
//            }
//
//            self.content.text = link.title
//            self.url.text = link.url
//            self.date.text = String(describing: link.date!)
//            self.category.text = link.category?.name
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
