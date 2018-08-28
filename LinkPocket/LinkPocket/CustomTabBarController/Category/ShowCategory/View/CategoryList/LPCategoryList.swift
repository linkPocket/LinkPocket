//
//  LPCategoryList.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPCategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //첫번째 카테고리 추가하는 플러스 버튼, 두번째 all
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPCategoryListCell = mLPCategoryList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPCategoryListCell
        
        var urls: [LPLinkModel] = []
        for i in 0..<self.urls.count {
            if self.urls[i].category?.name == categorys[indexPath.row].name {
                urls.append(self.urls[i])
                cell.urls.append(self.urls[i])
            }
        }
        print(cell.urls.count)
        
        cell.modifyCell(categoryN: categorys[indexPath.row].name!, urlCount: "\(urls.count)" )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = mLPCategoryList.cellForItem(at: indexPath) as? LPCategoryListCell else {
            return
        }
        
        displayCategoryTable(categoryN: cell.categoryNL.text!, urls: cell.urls )
        print(mLPCategoryList.subviews.count )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 26, bottom: 20, right: 26)
    }
    
}
