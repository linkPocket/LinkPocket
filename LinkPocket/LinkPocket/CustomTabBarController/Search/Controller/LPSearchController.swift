//
//  LPSearchController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchController: UIViewController, LPCoreDataManager {

    var categorys: [LPCategoryModel] = []
    var mLPSearchView: LPSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categorys = selectAllObjectFromCategory() as! [LPCategoryModel]
        
        mLPSearchView = LPSearchView(frame: R(0,0,W,H), categorys: categorys)
        self.view.addSubview(mLPSearchView)
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
