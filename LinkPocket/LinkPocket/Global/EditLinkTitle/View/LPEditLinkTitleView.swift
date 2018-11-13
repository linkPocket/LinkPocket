//
//  LPEditLinkTitleView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol LPEditLinkTitleViewListener {
    func saveAlert()
}

class LPEditLinkTitleView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var url: UILabel!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    var imageName: String = ""
    var date: NSDate!
    var categoryN: String = ""

    var buttonConstraint: NSLayoutConstraint!
    var listener: LPEditLinkTitleViewListener?
    
    override func awakeFromNib() {
        url.text = ""
        date = Date() as NSDate

        buttonConstraint = finishBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint.isActive = true
        self.title.becomeFirstResponder()
        self.title.delegate = self
        self.finishBtn.addTarget(self, action: #selector(finishBtnClicked), for: .touchDown)
        setImageView()
        subscribeToShowKeyboardNotifications()
    }
    
    func setBaseData(categoryN: String, image: String, title: String, url: String, date: NSDate) {

        self.categoryN = categoryN
        self.imageName = image
        self.title.text = title
        self.date = date
        self.url.text = url
        
        if let data = try? Data(contentsOf: URL(string: imageName)!)
        {
            self.imageView.image = UIImage(data: data)
        }
    }
    
    func setImageView() {
        self.imageView.layer.cornerRadius = 8.0
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.backgroundColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1)
        self.imageView.layer.borderColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1).cgColor
    }

    func saveAlertAction() {
        let categoryModel = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: categoryN)
        let updateLink: LPLinkModel = LPLinkModel(url: url.text!, title: title.text!, imageName: imageName, date: self.date, category: categoryModel)
        
        LPCoreDataManager.store.updateLinkSet(valueLink: updateLink, whereUrlIs: url.text!)
    }
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func finishBtnClicked() {
        self.listener?.saveAlert()
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        }
    }
}
