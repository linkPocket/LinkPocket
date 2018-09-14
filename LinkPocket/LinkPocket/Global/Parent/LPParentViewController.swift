//
//  LPParentViewController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 6..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func AlertTwo(title: String, message: String, yes: String = "네", no: String = "아니요", yesAction: (@escaping()->()), noAction: (()->())?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesBT = UIAlertAction(title: yes, style: .default) {
            (action: UIAlertAction) -> Void in
            yesAction()
        }
        
        
        let noBT = UIAlertAction(title: no, style: .default) {
            (action: UIAlertAction) -> Void in
            noAction?()
        }
        
        alert.addAction(noBT)
        alert.addAction(yesBT)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    func AlertOno(title: String, message: String, bt: String, btAction: (()->())?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let BT = UIAlertAction(title: bt, style: .default) {
            (action: UIAlertAction) -> Void in
            btAction?()
        }
        
        
        alert.addAction(BT)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    func AlertDisappear(title: String = "빈칸을 채워주세요", message: String = ""){
        
        let alert = UIAlertController(title: title,message: message ,preferredStyle:.alert)
        self.present(alert ,animated: false, completion:{
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.dismiss(animated: true, completion: nil)
                
            })
            
        })
        
    }

}
