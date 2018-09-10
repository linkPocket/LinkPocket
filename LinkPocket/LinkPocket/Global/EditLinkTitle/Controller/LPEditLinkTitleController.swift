//
//  LPEditLinkTitleController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPEditLinkTitleController: UIViewController {

    var mLPEditLinkTitleView: LPEditLinkTitleView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mLPEditLinkTitleView = Bundle.main.loadNibNamed("LPEditLinkTitleView", owner: self, options: nil)?.first as? LPEditLinkTitleView
        self.view.addSubview(mLPEditLinkTitleView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
