//
//  LPSearchController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPRecentViewController: UIViewController { //LPSearchController

    var categorys: [LPCategoryModel] = []
    var urls: [LPLinkModel] = []
    var mLPSearchView: LPSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let mLPSearchView = Bundle.main.loadNibNamed("LPSearchView", owner: self, options: nil)?.first as? LPSearchView {
            self.view.addSubview(mLPSearchView)
        }

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
