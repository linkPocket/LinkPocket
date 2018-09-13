//
//  EachCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class EachCategoryController: UIViewController {
    
    var mEachCategoryView = EachCategoryView()
    var editStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let editBt = UIBarButtonItem(title: "Eidt", style: .done, target: self, action: #selector(editBtAction))
        self.navigationItem.rightBarButtonItem  = editBt
        
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
        mEachCategoryView.displayCategoryPage(categoryName: categoryName, categoryCount: categoryCount, urls: urls)
        print(categoryCount)
    }
    
}
