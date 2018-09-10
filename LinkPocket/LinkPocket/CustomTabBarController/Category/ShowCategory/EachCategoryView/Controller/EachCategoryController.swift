//
//  EachCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class EachCategoryController: LPParentViewController, UINavigationControllerDelegate, EachCategoryViewListener {

    var mEachCategoryView = EachCategoryView()
    var editStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImage(named: "edit")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(editBtAction))
        
        self.navigationController?.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func editBtAction(){
       mEachCategoryView.editBtAction()
    }
    
    func displayCategoryPage(categoryName: String, categoryCount: String, urls: [LPTableSectionModel]) {
        mEachCategoryView = (Bundle.main.loadNibNamed("EachCategoryView", owner: self, options: nil)?.first as? EachCategoryView)!
        self.view.addSubview(mEachCategoryView)
        mEachCategoryView.listener = self
        mEachCategoryView.displayCategoryPage(categoryName: categoryName, categoryCount: categoryCount, urls: urls)
        print(categoryCount)
    }
    
    func confirmMoveAlert() {
        func yesAction() { mEachCategoryView.moveYesAction() }
        func noAction() { mEachCategoryView.moveNoAction() }
        
        self.AlertTwo(title: "카테고리 이동", message: "이동하시겠습니까?", yes: "네", no: "아니요", yesAction: yesAction, noAction: noAction)
    }
    
    func confirmDeleteAlert() {
        func yesAction() { mEachCategoryView.deleteYesAction() }
        func noAction() { mEachCategoryView.deleteNoAction() }
        
        self.AlertTwo(title: "삭제하시겠습니까?", message: "영구적으로 삭제됩니다.", yes: "네", no: "아니요", yesAction: yesAction, noAction: noAction)
    }
    
    //BackBT Event 이거 왜 안되냐
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        let categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        (viewController as? LPCategoryViewController)?.refreshData(urls: urls , categorys: categorys )
    }
    
}
