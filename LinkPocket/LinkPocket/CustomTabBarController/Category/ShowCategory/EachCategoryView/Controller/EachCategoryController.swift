//
//  EachCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class EachCategoryController: LPParentViewController, EachCategoryViewListener {

    var mEachCategoryView = EachCategoryView()
    var editStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImage(named: "edit")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(editBtAction))
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let upsideViewHeight: CGFloat = size.width > size.height ? 50 : 192
        let categoryNameTop: CGFloat = size.width > size.height ? 3 : 52
        self.mEachCategoryView.upsideViewHeight.constant = upsideViewHeight
        self.mEachCategoryView.categoryNameTop.constant = categoryNameTop
    }
    
    override func reloadViews() {
        self.mEachCategoryView.editReloadData()
    }
    
    @objc func editBtAction(){
       mEachCategoryView.editBtAction()
    }
    
    func displayCategoryPage(categoryName: String, categoryCount: String, urls: [LPTableSectionModel]) {
        mEachCategoryView = (Bundle.main.loadNibNamed("EachCategoryView", owner: self, options: nil)?.first as? EachCategoryView)!
        self.view.addSubview(mEachCategoryView)
        mEachCategoryView.listener = self
        mEachCategoryView.displayCategoryPage(categoryName: categoryName, categoryCount: categoryCount, urls: urls)
    }
    
    func confirmMoveAlert() {
        func yesAction() {
            mEachCategoryView.moveAction()
            mEachCategoryView.finishEdit()
        }
        func noAction() { }
        
        self.AlertTwo(title: "카테고리 이동", message: "이동하시겠습니까?", yes: "네", no: "아니요", yesAction: yesAction, noAction: noAction)
    }
    
    func confirmDeleteAlert() {
        func yesAction() {
            mEachCategoryView.deleteYesAction()
            mEachCategoryView.finishEdit()
        }
        func noAction() { }
        
        self.AlertTwo(title: "삭제하시겠습니까?", message: "영구적으로 삭제됩니다.", yes: "네", no: "아니요", yesAction: yesAction, noAction: noAction)
    }
    
    func confirmEachDeleteAlert() {
        func yes() {
            mEachCategoryView.deleteAlertAction()
        }
        func no() { }
        self.AlertTwo(title: "삭제하시겠습니까?", message: "영구적으로 삭제됩니다.", yesAction: yes, noAction: no)
        
    }
    
    func noneSeletedCells() {
        self.AlertOno(title: "선택된 항목이 없습니다.", message: "편집하려는 항목들을 선택해주세요.", bt: "확인", btAction: nil)
    }
    
    func finishEdit() {
        var image = UIImage(named: "edit")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(editBtAction))
    }
    
    func startEdit() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action:  #selector(editBtAction))
    }
}
