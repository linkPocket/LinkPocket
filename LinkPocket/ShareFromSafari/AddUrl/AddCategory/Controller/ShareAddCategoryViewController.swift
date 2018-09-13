//
//  ShareAddCategoryViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import Lottie

class ShareAddCategoryViewController: UIViewController {
    
    var addCategoryView: ShareAddCategoryView?
    var imageInfo: ShareImageInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "추가하기"
        
        guard let customView = Bundle.main.loadNibNamed("ShareAddCategoryView", owner: self, options: nil)?.first as? ShareAddCategoryView else {
            return
        }
        
        addCategoryView = customView
        addCategoryView?.delegate = self
        self.view.addSubview(addCategoryView!)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: nil) { (_) in
            
            self.addCategoryView?.margin = size.width > size.height ? 10 : 80
            self.addCategoryView?.topMargin.constant = (self.addCategoryView?.margin)!
            self.addCategoryView?.bottomMargin.constant = (self.addCategoryView?.margin)!
            self.view.layoutIfNeeded()
        }
    }
}

extension ShareAddCategoryViewController: ShareAddCategoryViewDelegate {
    func saveUrlInfo() {
        var category: LPCategoryModel = LPCategoryModel()
        
        category.name = self.addCategoryView?.categoryNameTextField.text!
        let color = addCategoryView?.collectionViewAdapter.selectedCellColor
        color == nil ? category.setRGBA(color: .white) : category.setRGBA(color:color!)
        guard LPCoreDataManager.store.insertIntoCategory(valueCategory: category) else {
            createCategoryFailed()
            return
        }
        
        let imageNumber = UserDefaults.standard.integer(forKey: "imageNumber")
        
        let appendingPathComponent = "\(imageNumber).png"
        
        UserDefaults.standard.set(imageNumber + 1, forKey: "imageNumber")
        UserDefaults.standard.synchronize()

        let link: LPLinkModel = LPLinkModel(url: self.imageInfo?.url, title: self.imageInfo?.titleText, imageName: writeFile(appendingPathComponent)?.relativeString, date: Date() as NSDate, category: category)

        guard LPCoreDataManager.store.insertIntoLink(valueLink: link) else {
            createLinkFailed()
            return
        }
        
        let confirmVC = ShareConfirmViewController(nibName: "ShareConfirmViewController", bundle: nil)
        self.present(confirmVC, animated: false, completion: nil)
    }
    
    func createCategoryFailed() {
        let alertController = UIAlertController(title: "카테고리를 만들 수 없습니다", message: "카테고리가 있는지 확인해보세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createLinkFailed() {
        let alertController = UIAlertController(title: "링크를 만들 수 없습니다", message: "링크가 있는지 확인해보세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func writeFile(_ appendingPathComponent: String) -> URL? {
        var photoURL: URL? = nil
        if let data = UIImagePNGRepresentation((self.imageInfo?.image)!) {
            photoURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.CoreDataTest2")?.appendingPathComponent(appendingPathComponent)
            print("photo url : \(String(describing: photoURL))")
            do {
                try data.write(to: photoURL!, options: .atomic)
            } catch {
                print("\(#file)#\(#function)(\(#line)): error: \(error.localizedDescription)")
            }
        }
        
        return photoURL
    }
}
