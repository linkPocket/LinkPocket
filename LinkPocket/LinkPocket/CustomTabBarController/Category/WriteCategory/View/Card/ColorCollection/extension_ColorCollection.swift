//
//  extension_ColorCollection.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPWriteCategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPColorCell = cardColorCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPColorCell
        
        cell.modifyCell(color: colorArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard (cardColorCollection.cellForItem(at: indexPath) as? LPColorCell) != nil else {
            return
        }
        
        for i in 0..<cardColorCollection.subviews.count - 2 {
            if i == indexPath.row {
                (cardColorCollection.subviews[indexPath.row] as! LPColorCell).onClicked()
            } else {
                (cardColorCollection.subviews[i] as! LPColorCell).onUnclicked()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 19, height: 19)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
    }
    
}
