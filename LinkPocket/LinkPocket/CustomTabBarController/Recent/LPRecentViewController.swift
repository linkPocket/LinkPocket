//
//  LPRecentViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPRecentViewController: UIViewController, LPCoreDataManager {
    
    var mLPRecentView: LPRecentView!
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        urls = selectAllObjectFromLink() as! [LPLinkModel]
        categorys = selectAllObjectFromCategory() as! [LPCategoryModel]
        
        mLPRecentView = LPRecentView(frame: R(0,0,W,H), urls: urls)
        self.view.addSubview(mLPRecentView)
        
        
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
