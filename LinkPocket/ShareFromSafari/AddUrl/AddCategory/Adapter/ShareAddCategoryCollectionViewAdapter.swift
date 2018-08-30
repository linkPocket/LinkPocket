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
        categoriesColor.append(.black)
        categoriesColor.append(.darkGray)
        categoriesColor.append(.gray)
        categoriesColor.append(.lightGray)
        categoriesColor.append(.brown)


        categoriesColor.append(.red)
        categoriesColor.append(.magenta)
        categoriesColor.append(.orange)
        categoriesColor.append(.yellow)
        categoriesColor.append(.green)

        categoriesColor.append(.blue)
        categoriesColor.append(.cyan)
        categoriesColor.append(.purple)
        
        categoriesColor.append(.white)
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
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShareAddCategoryCollectionViewCell else { return }
    }
}

