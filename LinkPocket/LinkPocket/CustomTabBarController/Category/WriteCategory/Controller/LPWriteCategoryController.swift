//
//  LPWriteCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPWriteCategoryController: UIViewController {
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    var mLPWriteCategoryView: LPWriteCategoryView!
    var status: String = "CreatCategory" //CreatCategory || EditCategory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if status == "CreatCategory" {
        self.navigationItem.title = "추가하기"
        } else {
            self.navigationItem.title = "수정하기"
        }
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBaseData(title: String, color: UIColor) {
        mLPWriteCategoryView = Bundle.main.loadNibNamed("LPWriteCategoryView", owner: self, options: nil)?.first as? LPWriteCategoryView
        mLPWriteCategoryView.status = self.status
        self.view.addSubview(mLPWriteCategoryView)
        
        mLPWriteCategoryView.setBaseData(title: title, color: color)
        
    }
    

}
