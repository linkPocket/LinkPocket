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
    
    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    var listener: LPCategoryVListener!
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        mLPCategoryList.register(UINib(nibName: "LPCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        layout.itemSize = CGSize(width: 100, height: 42)
        layout.minimumInteritemSpacing = 11
        layout.minimumLineSpacing = 40
        mLPCategoryList!.collectionViewLayout = layout

    }
    
    func writeCategoryAppear() {
        let writeCategory = LPWriteCategoryController(nibName: "LPWriteCategoryController", bundle: nil)
        LPParentNavigationController.sharedInstance.pushViewController(writeCategory, animated: true)

    }

    func displayCategoryTable(categoryN: String, urls: [LPLinkModel]) {
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        
        let eachCategory = EachCategoryController(nibName: "EachCategoryController", bundle: nil)
        eachCategory.displayCategoryPage(categoryName: categoryN, categoryCount: "\(urls.count)", urls: tableItems)
        LPParentNavigationController.sharedInstance.pushViewController(eachCategory, animated: true)

    }
    
    func addCategory() {
        self.listener?.startWriteCategory()
    }
    
}
