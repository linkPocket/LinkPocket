//
//  LPSelectCollectionViewAdapter.swift
//  LinkPocket
//
//  Created by user on 2018. 11. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol LPSelectCollectionViewAdapterDelegate {
    func collectionViewCellDidClicked(image: UIImage)
}


class LPSelectCollectionViewAdapter:  NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LPHtmlParserDelegate {
    
    var parsingImages: [UIImage] = [UIImage]()
    let identifier: String = "ShareSelectCollectionViewCell"
    let collectionView: UICollectionView? = nil
    var delegate: LPSelectCollectionViewAdapterDelegate?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.width / 3.5)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parsingImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ShareSelectCollectionViewCell
        
        cell.modifyCell(with: parsingImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShareSelectCollectionViewCell else { return }
        if let validCellImage = cell.imageView.image {
            self.delegate?.collectionViewCellDidClicked(image: validCellImage)
        }
    }
}
