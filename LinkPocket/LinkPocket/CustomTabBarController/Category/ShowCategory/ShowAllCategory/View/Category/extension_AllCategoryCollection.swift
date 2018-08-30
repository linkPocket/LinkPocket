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
        return categorys.count + 2
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPCategoryListCell = mLPCategoryList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPCategoryListCell
        
        if indexPath.row == 0 {
            cell.modeifyImageCell(image: "add")
        } else if indexPath.row == 1 {
            cell.modifyCell(categoryN: "All", urlCount: "\(urls.count)")
        } else {
        let item = categorys[indexPath.row - 2]
        var urls: [LPLinkModel] = []
        for i in 0..<self.urls.count {
            if self.urls[i].category?.name == item.name {
                urls.append(self.urls[i])
            }
        }
         cell.modifyCell(categoryN: item.name!, urlCount: "\(urls.count)")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = mLPCategoryList.cellForItem(at: indexPath) as? LPCategoryListCell else {
            return
        }
        if cell.image.isHidden == false {
            let writeVC = LPWriteCategoryController(nibName: "LPWriteCategoryController", bundle: nil)
            LPParentNavigationController.sharedInstance.pushViewController(writeVC, animated: true)
        } else {
        
        let categoryVC = EachCategoryController(nibName: "EachCategoryController", bundle: nil)
        let grouping = LPGroupingTable(urls: urls)
        categoryVC.displayCategoryPage(categoryName: cell.categoryNL.text!, categoryCount: "\(cell.urls.count)", urls: grouping)
        LPParentNavigationController.sharedInstance.pushViewController(categoryVC, animated: true)
            
        }
    }

}
