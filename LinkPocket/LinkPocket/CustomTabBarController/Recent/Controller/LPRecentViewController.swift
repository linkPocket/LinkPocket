//
//  LPRecentViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData

class LPRecentViewController: LPParentViewController, LPRecentViewListener {

    var mLPRecentView: LPRecentView!
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        mLPRecentView = Bundle.main.loadNibNamed("LPRecentView", owner: self, options: nil)?.first as? LPRecentView
        mLPRecentView.listener = self
        self.view.addSubview(mLPRecentView)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func deleteAlertAction() {
        func yes() {
            mLPRecentView.deleteAlertAction()
        }
        func no() { }
        self.AlertTwo(title: "삭제하시겠습니까?", message: "영구적으로 삭제됩니다.", yesAction: yes, noAction: no)
    }

}
