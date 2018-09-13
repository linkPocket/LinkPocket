//
//  EachCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol EachCategoryViewListener {
    func confirmDeleteAlert()
    func confirmMoveAlert()
}

class EachCategoryView: UIView {

    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    var editSelectedURL: [String] = []
    
    var listener: EachCategoryViewListener?
    
    var statusEdit: Bool = false
    
    var moveLinks: [LPLinkModel] = []
    
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryCount: UILabel!
    
    @IBOutlet weak var categoryTable: UITableView!
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        categoryName.isEnabled = false
        
        categoryTable.separatorStyle = .none
        categoryTable.register(UINib(nibName: "LPLinkTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        categoryTable.reloadData()
        
        moveCollection.register(UINib(nibName: "LPSearchCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        moveCollection.dataSource = self
        moveCollection.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: 70, height: 55)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 0
        moveCollection!.collectionViewLayout = layout
        
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
    @IBOutlet weak var moveCollection: UICollectionView!
    @IBOutlet weak var underBarBottom: NSLayoutConstraint!
    @IBOutlet weak var moveCollectionBottom: NSLayoutConstraint!
    
    
    //MARK:--  옮기기에 관한 모든것~~!
    var moveCategoryN: String = ""
    @IBAction func urlMoveAction(_ sender: UIButton) {
        print(editSelectedURL)
       
        if self.moveCollectionBottom.constant == 0 {
            UIView.animate(withDuration: 0.1, animations: {
                self.moveCollectionBottom.constant = -88
                self.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.moveCollectionBottom.constant = 0
                self.layoutIfNeeded()
            })
        }
        
        //self.listener?.confirmMoveAlert()
    }
    
    //MARK:-- 삭제에 관련된 모든거 ( 삭제 에니메이션이랑 alert관련된것들까지)
    @IBAction func urlDeleteAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            self.moveCollectionBottom.constant = -88
            self.layoutIfNeeded()
        })
        
        self.listener?.confirmDeleteAlert()
    }
    
    // Alert func about delete
    func deleteYesAction() {
        for i in 0..<editSelectedURL.count {
            LPCoreDataManager.store.deleteFromLinkWhere(urlIs: editSelectedURL[i] )
        }
        editReloadData()
    }
    
    func editReloadData() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        if categoryName.text != "All" {
            var links: [LPLinkModel] = []
            for i in 0..<urls.count {
                if urls[i].category?.name == categoryName.text {
                    links.append(urls[i])
                }
            }
            urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
            tableItems = LPGroupingTable(urls: links)
           
        } else {
           tableItems = LPGroupingTable(urls: urls)
        }
        
        categoryTable.reloadData()
        
        var allOfUrl: Int = 0
        for i in 0..<tableItems.count {
            allOfUrl += tableItems[i].urls.count
        }
        self.categoryCount.text = "\(allOfUrl)"
    }
}
