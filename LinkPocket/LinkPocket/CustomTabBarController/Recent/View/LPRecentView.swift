//
//  LPRecentView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPRecentView: UIView {
    
    @IBOutlet weak var mSearchBar: UISearchBar!
    @IBOutlet weak var mLPCategoryTable: UITableView!
    
    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []

    override func awakeFromNib() {
   
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        tableItems = LPGroupingTable(urls: urls)
        mLPCategoryTable.reloadData()
        
        mLPCategoryTable.separatorStyle = .none
    }
    
}
