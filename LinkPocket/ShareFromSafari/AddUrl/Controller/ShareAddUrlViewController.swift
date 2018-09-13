//
//  ShareAddUrlViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import Lottie

class ShareAddUrlViewController: UIViewController {
    
    var imageInfo: ShareImageInfoModel = ShareImageInfoModel()
    
    var titleText: String = String()
    var addUrlView: ShareAddUrlView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let customView = Bundle.main.loadNibNamed("ShareAddUrlView", owner: self, options: nil)?.first as? ShareAddUrlView else {
            return
        }

        addUrlView = customView
        addUrlView?.imageView.image = self.imageInfo.image
        addUrlView?.titleTextView.text = self.imageInfo.titleText
        addUrlView?.delegate = self
        addUrlView?.tableViewAdapter?.delegate = self
        getCategoryList()
        self.view.addSubview(addUrlView!)
        
        let tapTerm:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTextView))
        self.addUrlView?.titleTextView.addGestureRecognizer(tapTerm)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addUrlView?.titleTextView.text = imageInfo.titleText
        self.title = "추가 하기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    @objc func tapTextView() {
        let editTitleVC: ShareEditTitleViewController = ShareEditTitleViewController(nibName: "ShareEditTitleViewController", bundle: nil, imageInfo: self.imageInfo)
        editTitleVC.delegate = self
        ShareParentNaviController.rootNaviController.pushViewController(editTitleVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getCategoryList() {
        DispatchQueue.main.async {
            self.addUrlView?.tableViewAdapter?.categoryModelList = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
            self.addUrlView?.tableView.reloadData()
        }
    }
}

extension ShareAddUrlViewController: ShareEditTitleViewControllerDelegate {
    func finishEdit(text: String) {
        DispatchQueue.main.async {
            self.imageInfo.titleText = text
        }
    }
}

extension ShareAddUrlViewController: ShareAddUrlViewDelegate {
    func floatingBtnClicked() {
        let addCategoryVC = ShareAddCategoryViewController(nibName: "ShareAddCategoryViewController", bundle: nil)
        addCategoryVC.imageInfo = self.imageInfo
        ShareParentNaviController.rootNaviController.pushViewController(addCategoryVC, animated: true)
    }
}

extension ShareAddUrlViewController: ShareAddUrlTableViewAdapterDelegate {
    
    func cellDidClicked(category: LPCategoryModel) {
        let imageNumber = UserDefaults.standard.integer(forKey: "imageNumber")
        
        let appendingPathComponent = "\(imageNumber).png"
        
        UserDefaults.standard.set(imageNumber + 1, forKey: "imageNumber")
        UserDefaults.standard.synchronize()

        let link: LPLinkModel = LPLinkModel(url: self.imageInfo.url, title: self.imageInfo.titleText, imageName: writeFile(appendingPathComponent)?.relativeString, date: Date() as NSDate, category: category)
        
        guard LPCoreDataManager.store.insertIntoLink(valueLink: link) else {
            createLinkFailed()
            return
        }
        
        let confirmVC = ShareConfirmViewController(nibName: "ShareConfirmViewController", bundle: nil)
        self.present(confirmVC, animated: false, completion: nil)
    }
    
    func createLinkFailed() {
        let alertController = UIAlertController(title: "링크를 만들 수 없습니다", message: "링크가 있는지 확인해보세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func writeFile(_ appendingPathComponent: String) -> URL? {
        var photoURL: URL? = nil
        if let data = UIImagePNGRepresentation(self.imageInfo.image) {
            photoURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.CoreDataTest2")?.appendingPathComponent(appendingPathComponent)
            do {
                try data.write(to: photoURL!, options: .atomic)
            } catch {
                print("\(#file)#\(#function)(\(#line)): error: \(error.localizedDescription)")
            }
        }
        return photoURL
    }
}
