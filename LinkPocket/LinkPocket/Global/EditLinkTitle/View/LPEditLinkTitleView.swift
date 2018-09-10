//
//  LPEditLinkTitleView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPEditLinkTitleView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var url: UILabel!
    
    @IBOutlet weak var successBottom: NSLayoutConstraint!
    
    
    var imageName: String = ""
    var date: NSDate!
    var categoryN: String = ""
    
    override func awakeFromNib() {
        imageView.image = UIImage(named: "")
        title.placeholder = ""
        url.text = ""
        date = Date() as NSDate
        title.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func setBaseData(categoryN: String, image: String, title: String, url: String, date: NSDate) {
        self.categoryN = categoryN
        print(image)
        //self.imageView.image = UIImage(named: "")
        self.imageName = image
        self.title.placeholder = title
        self.date = date
        self.url.text = url
    }
    
    @IBAction func editSuccessAction(_ sender: UIButton) {
        let categoryModel = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: categoryN)
        let updateLink: LPLinkModel = LPLinkModel(url: url.text!, title: title.text!, imageName: imageName, date: self.date, category: categoryModel)
        
        LPCoreDataManager.store.updateLinkSet(valueLink: updateLink, whereUrlIs: url.text!)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        
        successBottom.constant = -keyboardHeight
    }
    
}
