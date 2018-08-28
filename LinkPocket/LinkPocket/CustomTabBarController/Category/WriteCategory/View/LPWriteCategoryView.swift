//
//  LPWriteCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPWriteCategoryView: UIView/*, LPCategoryListListener*/ { //LPWriteCategoryView
    
    @IBOutlet weak var mCategoryList: UICollectionView!

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var cardColorCollection: UICollectionView!
    var colorArray: [UIColor] = [blue, red, yellow, green, purple]
    
   
    @IBOutlet weak var saveBt: UIButton!
    
    var listener: LPCategoryVListener!
    
    override func awakeFromNib() {
     
        saveBt.backgroundColor = blue
        
        cardColorCollection.register(UINib(nibName: "LPColorCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        cardTextField.becomeFirstResponder()
        cardView.layer.cornerRadius = 2
        cardView.Shadow(color: UIColor.colorFromRGB(0xD3D3D3), opacity: 0.2, offSet: CGSize(width: 0.2, height: 0.2), radius: 5*r, scale: true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

    }
    
    
    @IBAction func saveBtAction(_ sender: UIButton) {
    }
    
    func addCategory() {
        self.listener?.startWriteCategory()
    }
    
    func categorySaveAction(categoryN: String, color: UIColor) {
        print("그냥 바로 저장하면 됩니다.")
    }
    
    
    @IBOutlet weak var saveBtBottomConstraint: NSLayoutConstraint!
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
           
            saveBtBottomConstraint.constant = keyboardHeight
        }
    }
}

extension LPWriteCategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
  
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
        guard let cell = cardColorCollection.cellForItem(at: indexPath) as? LPColorCell else {
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
    
}
