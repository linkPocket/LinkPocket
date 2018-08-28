//
//  LPWriteCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPWriteCategoryController: UIViewController, LPCategoryVListener {

    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        if let mLPWriteCategoryView = Bundle.main.loadNibNamed("LPWriteCategoryView", owner: self, options: nil)?.first as? LPWriteCategoryView {
            self.view.addSubview(mLPWriteCategoryView)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startWriteCategory() {
        print("카테고리 여러개 추가할 수 있는거")
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
