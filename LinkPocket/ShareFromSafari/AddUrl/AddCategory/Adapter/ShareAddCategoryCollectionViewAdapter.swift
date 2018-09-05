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

    let blue = UIColor.colorFromRGB(0x008eff)
    let purple = UIColor.colorFromRGB(0x9013FE)
    let red = UIColor.colorFromRGB(0xF70000)
    let yellow = UIColor.colorFromRGB(0xF8E71C)
    let green = UIColor.colorFromRGB(0x10E10E)

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
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShareAddCategoryCollectionViewCell else { return }
    }
}

extension UIColor {
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
