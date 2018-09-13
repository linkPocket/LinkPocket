//
//  LPCustomTabBarController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCustomTabBarController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var customTabBar: UITabBar!
    
    var viewControllers: [UIViewController?] = [nil]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customTabBar.delegate = self
        let tabBar = self.customTabBar
        tabBar?.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.red, size:
            CGSize(width: (tabBar?.frame.width)!/CGFloat((tabBar?.items!.count)!)/2, height: (tabBar?.frame.height)!), lineWidth: 2.0)
        
        self.customTabBar.items?[0].title = self.viewControllers[0]?.tabBarItem.title
        self.customTabBar.items?[1].title = self.viewControllers[1]?.tabBarItem.title

        self.customTabBar.isTranslucent = false
        
        self.viewControllers[0]?.view.frame = self.customView.frame
        self.customView.insertSubview((self.viewControllers[0]?.view!)!, belowSubview: self.customTabBar)
        self.customTabBar.selectedItem = self.customTabBar.items?[0]
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "LINK POCKET"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            if self.viewControllers[0] == nil {
                self.viewControllers[0] = LPRecentViewController()
            }
            print("select tab's view frame : \(self.view.frame)")
            
            self.viewControllers[0]?.view.frame = self.customView.frame
            self.customView.insertSubview((self.viewControllers[0]?.view!)!, belowSubview: self.customTabBar)
        case 2:
            if self.viewControllers[1] == nil {
                self.viewControllers[1] = LPCategoryViewController()
            }
            self.viewControllers[1]?.view.frame = self.customView.frame
            self.customView.insertSubview((self.viewControllers[1]?.view!)!, belowSubview: self.customTabBar)
            
        default:
            break
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

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
