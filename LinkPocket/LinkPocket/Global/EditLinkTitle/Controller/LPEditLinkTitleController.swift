//
//  LPEditLinkTitleController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPEditLinkTitleController: LPParentViewController, LPEditLinkTitleViewListener {

    var mLPEditLinkTitleView: LPEditLinkTitleView!
    var linkModel = LPLinkModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "수정하기"
        mLPEditLinkTitleView = Bundle.main.loadNibNamed("LPEditLinkTitleView", owner: self, options: nil)?.first as? LPEditLinkTitleView
        mLPEditLinkTitleView.listener = self
        mLPEditLinkTitleView.setBaseData(categoryN: (linkModel.category?.name)!, image: linkModel.imageName!, title: linkModel.title!, url: linkModel.url!, date: linkModel.date!)

        self.view.addSubview(mLPEditLinkTitleView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBaseData(categoryN: String, image: String, title: String, url: String, date: NSDate) {
        let categoryModel = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: categoryN)
        self.linkModel.category = categoryModel
        self.linkModel.imageName = image
        self.linkModel.date = date
        self.linkModel.title = title
        self.linkModel.url = url
    }
    
    func saveAlert() {
        if mLPEditLinkTitleView.title.text != "" {
            func yes() {
                mLPEditLinkTitleView.saveAlertAction()
                LPParentNavigationController.sharedInstance.popViewController(animated: true)
            }
            func no() { }
            self.AlertTwo(title: "수정하시겠습니까?", message: "", yesAction: yes, noAction: no)
        } else {
            LPParentNavigationController.sharedInstance.popViewController(animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
