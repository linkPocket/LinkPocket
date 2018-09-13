//
//  extension_CategoryCollection.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPSearchView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPSearchCategoryListCell = SearchCategoryList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPSearchCategoryListCell
        
        let item = categorys[indexPath.row]
        var urlsArray: [LPLinkModel] = []
        for i in 0..<self.urls.count {
            if self.urls[i].category?.name == item.name {
                urlsArray.append(self.urls[i])
            }
        }
        
        cell.modifyCell(color: item.color()! , categoryN: item.name!, urls: urlsArray)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = SearchCategoryList.cellForItem(at: indexPath) as? LPSearchCategoryListCell else {
            return
        }
        
        let categoryVC = EachCategoryController(nibName: "EachCategoryController", bundle: nil)
        var grouping = LPGroupingTable(urls: cell.urls)
        grouping = grouping.sorted(by: { $0.section > $1.section })
        categoryVC.displayCategoryPage(categoryName: cell.categoryN, categoryCount: "\(cell.urls.count)", urls: grouping)
        LPParentNavigationController.sharedInstance.pushViewController(categoryVC, animated: true)   
    }
}
