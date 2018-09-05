//
//  LPSearchController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchController: UIViewController { //LPSearchController
    
    var categorys: [LPCategoryModel] = []
    var urls: [LPLinkModel] = []
    var inSearchMode: Bool = false
    
    var mLPSearchView = LPSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        dismissKeyboard() // 얘 왜 안되지
        
        mLPSearchView = (Bundle.main.loadNibNamed("LPSearchView", owner: self, options: nil)?.first as? LPSearchView)!
        self.view.addSubview(mLPSearchView)
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "URL, 카테고리 이름 검색.."
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func FilteredReload(filteredData: [LPSearchModel]){
        mLPSearchView.FilteredReload(filteredData: filteredData)
    }
    
}

