//
//  LPCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol LPCategoryVListener {
    func startWriteCategory()
}

class LPCategoryView: UIView {
    
    @IBOutlet weak var mLPCategoryList: UICollectionView!
    @IBOutlet weak var mLPCategoryTable: UITableView!
    
    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    var listener: LPCategoryVListener!
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        mLPCategoryList.register(UINib(nibName: "LPCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        mLPCategoryTable.register(LPCategoryTableCell.self, forCellReuseIdentifier: "Cell")
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
//        layout.itemSize = CGSize(width: W, height: H)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        mLPCategoryList!.collectionViewLayout = layout
        
        
        tableItems = LPGroupingTable(urls: urls)
        mLPCategoryTable.reloadData()
    }

    func displayCategoryTable(categoryN: String, urls: [LPLinkModel]) {
        tableItems = LPGroupingTable(urls: urls)
        mLPCategoryTable.reloadData()
    }
    
    func addCategory() {
        self.listener?.startWriteCategory()

    }
    
}
