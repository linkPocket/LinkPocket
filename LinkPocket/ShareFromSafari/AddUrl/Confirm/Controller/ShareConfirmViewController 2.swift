//
//  ShareConfirmViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import Lottie

class ShareConfirmViewController: UIViewController {
    
    var confirmView: ShareConfirmView?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let customView = Bundle.main.loadNibNamed("ShareConfirmView", owner: self, options: nil)?.first as? ShareConfirmView else {
            return
        }
        
        startTimer()
        
        confirmView = customView
        confirmView?.confirmLabel.alpha = 0

        self.view.addSubview(confirmView!)
        
        
        let animationView = LOTAnimationView(name: "ModernPictogramsForLottie_MagnifyingGlass")
        self.view.addSubview(animationView)
        
        setAnimation(animationView: animationView)
        
        animationView.play(completion: { finished in
            animationView.removeFromSuperview()
            UIView.animate(withDuration: 0.5, animations: {
                self.confirmView?.confirmLabel.alpha = 1
            })
        })
    }

    func setAnimation(animationView: LOTAnimationView) {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: animationView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 2.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: animationView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 2.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: animationView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: animationView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0).isActive = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(finishTimer),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func finishTimer() {
        ShareExtensionContext.sharedExtension?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
