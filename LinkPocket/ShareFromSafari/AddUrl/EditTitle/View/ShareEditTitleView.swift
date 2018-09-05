//
//  ShareEditTitleView.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol ShareEditTitleViewDelegate {
    func finishEdit(text: String)
}

class ShareEditTitleView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var finishBtn: UIButton!
    
    var buttonConstraint: NSLayoutConstraint!
    var delegate: ShareEditTitleViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonConstraint = finishBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint.isActive = true
        
        setImageView()
        setTitleTextView()
        setFinishBtn()
        subscribeToShowKeyboardNotifications()
    }
    
    func setImageView() {
        self.imageView.layer.cornerRadius = 8.0
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.backgroundColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1)
        self.imageView.layer.borderColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1).cgColor
    }
    
    func setTitleTextView() {
        self.titleTextView.becomeFirstResponder()
    }
    
    func dragAllTextview() {
        self.titleTextView.selectedTextRange = self.titleTextView.textRange(from: self.titleTextView.beginningOfDocument, to: self.titleTextView.endOfDocument)
    }
    
    func setFinishBtn() {
        self.finishBtn.addTarget(self, action: #selector(finishBtnClicked), for: .touchDown)
    }
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func finishBtnClicked() {
        self.delegate?.finishEdit(text: self.titleTextView.text!)
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
}
