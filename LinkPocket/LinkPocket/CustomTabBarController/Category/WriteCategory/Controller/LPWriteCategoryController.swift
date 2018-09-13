//
//  LPWriteCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPWriteCategoryController: LPParentViewController, LPWriteCategoryViewListener {
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    var mLPWriteCategoryView: LPWriteCategoryView!
    var status: String = "CreatCategory" //CreatCategory || EditCategory
    var categoryName: String = ""
    var writeView: LPWriteCategoryView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if status == "CreatCategory" {
            self.navigationItem.title = "추가하기"
        } else {
            self.navigationItem.title = "수정하기"
            var image = UIImage(named: "LPTrash")
            image = image?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(deleteAction))
        }
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        if let mLPWriteCategoryView = Bundle.main.loadNibNamed("LPWriteCategoryView", owner: self, options: nil)?.first as? LPWriteCategoryView {
            self.writeView = mLPWriteCategoryView
            self.view.addSubview(writeView!)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let margin: CGFloat = size.width > size.height ? 10 : 80
        self.writeView?.topMargin.constant = margin
        self.writeView?.bottomMargin.constant = margin
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBaseData(title: String, color: UIColor) {
        mLPWriteCategoryView = Bundle.main.loadNibNamed("LPWriteCategoryView", owner: self, options: nil)?.first as? LPWriteCategoryView
        mLPWriteCategoryView.status = self.status
        mLPWriteCategoryView.listener = self
        self.view.addSubview(mLPWriteCategoryView)
        
        mLPWriteCategoryView.setBaseData(title: title, color: color)
        
        self.categoryName = title
    }
    
    //MARK:- Alert ===============================================
    @objc func deleteAction() {
        func yes() {
            LPCoreDataManager.store.deleteFromCategoryWhere(nameIs: categoryName)
        }
        func no() { }
        self.AlertTwo(title: "카테고리를 삭제하시겠습니까?", message: "영구적으로 삭제됩니다.", yesAction: yes, noAction: no)
    }
    
    func saveAlert() {
        if mLPWriteCategoryView.cardTextField.text != "" {
            func yes() {
                mLPWriteCategoryView.saveAlertAction()
            }
            func no() { }
            self.AlertTwo(title: "저장하시겠습니까?", message: "", yesAction: yes, noAction: no)
        } else {
            self.AlertDisappear()
        }
    }
    //==============================================================
}
