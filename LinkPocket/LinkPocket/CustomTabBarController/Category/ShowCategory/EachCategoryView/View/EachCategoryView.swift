//
//  EachCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class EachCategoryView: UIView {

    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryCount: UILabel!
    
    @IBOutlet weak var categoryTable: UITableView!
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        categoryTable.separatorStyle = .none
        
        tableItems = LPGroupingTable(urls: urls)
        categoryTable.reloadData()
    }
    
    func displayCategoryPage(categoryName: String, categoryCount: String, urls: [LPTableSectionModel]) {
        self.categoryName.text = categoryName
        self.categoryCount.text = categoryCount + "  All"
        
        tableItems = urls
        categoryTable.reloadData()
    }

}
