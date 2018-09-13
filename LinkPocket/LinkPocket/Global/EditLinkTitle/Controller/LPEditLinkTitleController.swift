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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "수정하기"
        // Do any additional setup 기 loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBaseData(categoryN: String, image: String, title: String, url: String, date: NSDate) {
        mLPEditLinkTitleView = Bundle.main.loadNibNamed("LPEditLinkTitleView", owner: self, options: nil)?.first as? LPEditLinkTitleView
        mLPEditLinkTitleView.listener = self
        self.view.addSubview(mLPEditLinkTitleView)
        mLPEditLinkTitleView.setBaseData(categoryN: categoryN, image: image, title: title, url: url, date: date)
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
            self.AlertDisappear()
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
