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
    var editSelectedURL: [String] = []
    
    var statusEdit: Bool = false
    
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryCount: UILabel!
    
    @IBOutlet weak var categoryTable: UITableView!
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        categoryTable.separatorStyle = .none
        
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        categoryTable.reloadData()
        
        editCountLabel.layer.borderColor = UIColor.colorFromRGB(0x008EFF).cgColor
        editCountLabel.layer.borderWidth = 4
        editCountLabel.layer.cornerRadius = editCountLabel.bounds.height/2
    }
    
    func displayCategoryPage(categoryName: String, categoryCount: String, urls: [LPTableSectionModel]) {
        self.categoryName.text = categoryName
        self.categoryCount.text = categoryCount + "  All"
        
        tableItems = urls
        categoryTable.reloadData()
    }
    

    func editBtAction() {
        if statusEdit == false {
            statusEdit = true
            preparingEdit()
        } else {
            statusEdit = false
            finishEdit()
        }
    }
    
    //MARK:- underbar
    //MAKR:------------------------------------------------
    @IBOutlet weak var editCountLabel: UILabel!
    @IBOutlet weak var underBarBottom: NSLayoutConstraint!
    @IBAction func urlMoveAction(_ sender: UIButton) {
        print(editSelectedURL)
        print("이동합니다.")
    }
    
    @IBAction func urlDeleteAction(_ sender: UIButton) {
        print(editSelectedURL)
        print("삭제됩니다.")
    }
    
}
