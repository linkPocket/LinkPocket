//
//  ShareAddCategoryView.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol ShareAddCategoryViewDelegate {
    func saveUrlInfo()
}

class ShareAddCategoryView: UIView {
    
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var saveToCategoryBtn: UIButton!
    
    let identifier = "ShareAddCategoryCollectionViewCell"
    var collectionViewAdapter = ShareAddCategoryCollectionViewAdapter()
    var buttonConstraint: NSLayoutConstraint!
    var delegate: ShareAddCategoryViewDelegate?
    var margin: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()

        
        buttonConstraint = saveToCategoryBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint.isActive = true
        
        self.saveToCategoryBtn.backgroundColor = blue
        
        saveToCategoryBtn.addTarget(self, action: #selector(saveToCategory), for: .touchDown)
        let nibCell = UINib(nibName: identifier, bundle: nil)
        categoryCollectionView.register(nibCell, forCellWithReuseIdentifier: identifier)
        categoryCollectionView.delegate = collectionViewAdapter
        categoryCollectionView.dataSource = collectionViewAdapter

        
        margin = UIApplication.shared.statusBarOrientation.isLandscape ? 10 : 80
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        layout.itemSize = CGSize(width: 19, height: 19)
        layout.minimumInteritemSpacing = 31
        layout.minimumLineSpacing = 0
        categoryCollectionView!.collectionViewLayout = layout

        self.categoryNameTextField.becomeFirstResponder()
        subscribeToShowKeyboardNotifications()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 2
        cardView.Shadow(color: UIColor.colorFromRGB(0xD3D3D3), opacity: 0.2, offSet: CGSize(width: 0.2, height: 0.2), radius: 5*r, scale: true)
    }
    
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        buttonConstraint.constant = -10 - keyboardHeight
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonConstraint.constant = -10
    }
    
    @objc func saveToCategory() {
        self.delegate?.saveUrlInfo()
    }
}
