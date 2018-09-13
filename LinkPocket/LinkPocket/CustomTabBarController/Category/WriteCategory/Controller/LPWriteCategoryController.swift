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
    var writeView: LPWriteCategoryView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "추가 하기"
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        if let mLPWriteCategoryView = Bundle.main.loadNibNamed("LPWriteCategoryView", owner: self, options: nil)?.first as? LPWriteCategoryView {
            self.writeView = mLPWriteCategoryView
            self.view.addSubview(writeView!)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let margin: CGFloat = size.width > size.height ? 10 : 80
        self.writeView?.topMargin.constant = margin
        self.writeView?.bottomMargin.constant = margin
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
