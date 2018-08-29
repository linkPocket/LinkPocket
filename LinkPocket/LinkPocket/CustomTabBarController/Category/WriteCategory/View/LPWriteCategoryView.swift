//
//  LPWriteCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPWriteCategoryView: UIView {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var cardColorCollection: UICollectionView!
   
    var colorArray: [UIColor] = [blue, red, yellow, green, purple]
    
   @IBOutlet weak var saveBt: UIButton!
    
    override func awakeFromNib() {
        saveBt.backgroundColor = blue
        
        cardColorCollection.register(UINib(nibName: "LPColorCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        cardTextField.becomeFirstResponder()
        cardView.layer.cornerRadius = 2
        cardView.Shadow(color: UIColor.colorFromRGB(0xD3D3D3), opacity: 0.2, offSet: CGSize(width: 0.2, height: 0.2), radius: 5*r, scale: true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        layout.itemSize = CGSize(width: 19, height: 19)
        layout.minimumInteritemSpacing = 31
        layout.minimumLineSpacing = 0
        cardColorCollection!.collectionViewLayout = layout
    }
    
    
    @IBAction func saveBtAction(_ sender: UIButton) {
        print("카테고리 이름이랑 색깔 보고 저장해줘야해요 그냥 여기서 바로 저장하면됩니당")
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

