//
//  extension_moveCollection.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 5..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension EachCategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPSearchCategoryListCell = moveCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPSearchCategoryListCell
        
        let item = categorys[indexPath.row]
        var urlsArray: [LPLinkModel] = []
        for i in 0..<self.urls.count {
            if self.urls[i].category?.name == item.name {
                urlsArray.append(self.urls[i])
            }
        }
        
        cell.modifyCell(color: item.color()! , categoryN: item.name!, urls: urlsArray, usePlace: "Edit")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = moveCollection.cellForItem(at: indexPath) as? LPSearchCategoryListCell else {
            return
        }
        
        moveCategoryN = cell.categoryN
        var links: [LPLinkModel] = []
        for i in 0..<self.urls.count {
            if editSelectedURL.contains(self.urls[i].url!) {
                var url: LPLinkModel = self.urls[i]
                url.category = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: moveCategoryN)
                links.append(url)
            }
            
        }
        
        for i in 0..<links.count {
            LPCoreDataManager.store.updateLinkSet(valueLink: links[i], whereUrlIs: links[i].url!)
        }
        
        self.editReloadData()
    }
}
