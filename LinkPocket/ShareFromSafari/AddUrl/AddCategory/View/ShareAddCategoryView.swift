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
    
    @IBOutlet weak var categoryNameTextView: UITextView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var saveToCategoryBtn: UIButton!
    
    let identifier = "ShareAddCategoryCollectionViewCell"
    var collectionViewAdapter = ShareAddCategoryCollectionViewAdapter()
    var buttonConstraint: NSLayoutConstraint!
    var delegate: ShareAddCategoryViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        buttonConstraint = saveToCategoryBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint.isActive = true

        saveToCategoryBtn.addTarget(self, action: #selector(saveToCategory), for: .touchDown)
        let nibCell = UINib(nibName: identifier, bundle: nil)
        categoryCollectionView.register(nibCell, forCellWithReuseIdentifier: identifier)
        categoryCollectionView.delegate = collectionViewAdapter
        categoryCollectionView.dataSource = collectionViewAdapter
        
        
        self.categoryNameTextView.becomeFirstResponder()
        subscribeToShowKeyboardNotifications()
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
