//
//  extension_AllCategoryCollection.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPCategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count + 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPCategoryListCell = mLPCategoryList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPCategoryListCell
        
        if indexPath.row == 0 {
            cell.modifyAllCell(categoryN: "All", urlCount: "\(urls.count)", urls: urls)
            cell.onClicked()
        } else {
        let item = categorys[indexPath.row - 1]
        var urlsArray: [LPLinkModel] = []
        for i in 0..<self.urls.count {
            if self.urls[i].category?.name == item.name {
                urlsArray.append(self.urls[i])
            }
        }
            cell.modifyCell(category: item, urlCount: "\(urlsArray.count)", urls: urlsArray)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = mLPCategoryList.cellForItem(at: indexPath) as? LPCategoryListCell else {
            return
        }
        
        if collectionStatus == .ESFinished {
                let categoryVC = EachCategoryController(nibName: "EachCategoryController", bundle: nil)
                var grouping = LPGroupingTable(urls: cell.urls)
                grouping = grouping.sorted(by: { $0.section > $1.section })
                categoryVC.displayCategoryPage(categoryName: cell.categoryNL.text!, categoryCount: "\(cell.urls.count)", urls: grouping)
                LPParentNavigationController.sharedInstance.pushViewController(categoryVC, animated: true)
        } else {
            if cell.categoryNL.text != "All" {
                let writeVC = LPWriteCategoryController(nibName: "LPWriteCategoryController", bundle: nil)
                let cateogryModel = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: cell.categoryNL.text!)
                writeVC.status = "EditCategory"
                writeVC.setBaseData(title: cell.categoryNL.text!, color: (cateogryModel?.color())!)
                LPParentNavigationController.sharedInstance.pushViewController(writeVC, animated: true)
            } else {
                print("올일경우 편집할 수 없습니다.")
            }
        }
    }

}
