//
//  ShareEditTitleViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

//
//  ShareEditTitleViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol ShareEditTitleViewControllerDelegate {
    func finishEdit(text: String)
}

class ShareEditTitleViewController: UIViewController, ShareEditTitleViewDelegate {
    
    var imageInfo: ShareImageInfoModel
    var editTitleView: ShareEditTitleView?
    var delegate: ShareEditTitleViewControllerDelegate?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, imageInfo: ShareImageInfoModel) {
        self.imageInfo = imageInfo
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "추가 하기"
        
        self.loadEditTitleView()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeBtnClicked))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadEditTitleView() {
        if let customView = Bundle.main.loadNibNamed("ShareEditTitleView", owner: self, options: nil)?.first as? ShareEditTitleView {
            editTitleView = customView
            editTitleView?.imageView.image = self.imageInfo.image
            editTitleView?.titleTextView.text = self.imageInfo.titleText
            editTitleView?.dragAllTextview()
            editTitleView?.delegate = self
            
            self.view.addSubview(editTitleView!)
        }
    }
    
    @objc func closeBtnClicked() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func finishEdit(text: String) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
        self.delegate?.finishEdit(text: text)
    }
}

