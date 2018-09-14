//
//  ShareAddCategoryCollectionViewAdapter.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareAddCategoryCollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LPHtmlParserDelegate {
    
    var categoriesColor: [UIColor] = [UIColor]()
    let identifier: String = "ShareAddCategoryCollectionViewCell"
    var selectedCellColor: UIColor?

    override init() {
        categoriesColor.append(blue)
        categoriesColor.append(purple)
        categoriesColor.append(red)
        categoriesColor.append(yellow)
        categoriesColor.append(green)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ShareAddCategoryCollectionViewCell
        
        cell.modifyCell(color: categoriesColor[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection view clicked!!")
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShareAddCategoryCollectionViewCell else { return }
        selectedCellColor = cell.color
    }
}
