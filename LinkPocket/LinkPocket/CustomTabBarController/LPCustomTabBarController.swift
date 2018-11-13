//
//  LPCustomTabBarController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCustomTabBarController: LPParentViewController, UITabBarDelegate {
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var customTabBar: UITabBar!
    
    var viewControllers: [UIViewController?] = [LPRecentViewController(), LPCategoryViewController()]
    
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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        willEnterForeground()

        // Do any additional setup after loading the view.
    }

    @objc func willEnterForeground() {
        let pasteboard = UIPasteboard.general
        if let string = pasteboard.string {
            if string.isValidURL {
                let alert = UIAlertController(title: "복사된 URL", message: string, preferredStyle: .alert)
                let yesBT = UIAlertAction(title: "저장", style: .default) {
                    (action: UIAlertAction) -> Void in
                    let addUrlVC = LPSelectViewController(nibName: "LPSelectViewController", bundle: nil)
                    let encoded = string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)                    
                    print("\(encoded!) url")
                    addUrlVC.url = URL(string: encoded!)
                    LPParentNavigationController.sharedInstance.pushViewController(addUrlVC, animated: true)
                }
                
                
                let noBT = UIAlertAction(title: "취소", style: .default) {
                    (action: UIAlertAction) -> Void in
                }
                
                alert.addAction(noBT)
                alert.addAction(yesBT)
                
                self.present(alert, animated: false, completion: nil)

                print("\(string) is url")
            } else {
                print("\(string) is not url")
            }
        }
        UIPasteboard.general.items = []
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "LINK POCKET"
        reloadViews()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            if self.viewControllers[0] == nil {
                self.viewControllers[0] = LPRecentViewController()
            }
            
            self.viewControllers[0]?.view.frame = self.customView.frame
            reloadRecentView()
            self.customView.insertSubview((self.viewControllers[0]?.view!)!, belowSubview: self.customTabBar)
            
        case 2:
            if self.viewControllers[1] == nil {
                self.viewControllers[1] = LPCategoryViewController()
            }
            self.viewControllers[1]?.view.frame = self.customView.frame

            reloadCategoryView()
            self.customView.insertSubview((self.viewControllers[1]?.view!)!, belowSubview: self.customTabBar)
        default:
            break
        }
    }
    
    func reloadRecentView() {
        let categoryView = (self.viewControllers[0] as! LPRecentViewController).view.subviews[0] as! LPRecentView
        categoryView.reloadCategoryTable()
    }

    func reloadCategoryView() {
        let categoryView = (self.viewControllers[1] as! LPCategoryViewController).view.subviews[0] as! LPCategoryView
        categoryView.reloadCategory()
    }
    
    override func reloadViews() {
        if let tag = self.customTabBar.selectedItem?.tag {
            if tag == 1 {
                reloadRecentView()
            } else {
                reloadCategoryView()
            }
        }
    }
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
