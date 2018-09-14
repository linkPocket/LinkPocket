//
//  LPCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

enum LPEditStatus {
    case ESEdit
    case ESFinished
}

protocol LPCategoryVListener {
    func startWriteCategory()
}

class LPCategoryView: UIView {
    
    @IBOutlet weak var mLPCategoryList: UICollectionView!
    
    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    var listener: LPCategoryVListener!
    
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var blackView: UIButton!
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        labelHeight.constant = 0
        
        mLPCategoryList.register(UINib(nibName: "LPCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 21, bottom: 0, right: 21)
        layout.itemSize = CGSize(width: 100, height: 42)
        layout.minimumInteritemSpacing = 11
        layout.minimumLineSpacing = 40
        mLPCategoryList!.collectionViewLayout = layout

        let baseBTHeight = baseBT.bounds.height
        
        baseBT.layer.cornerRadius = baseBTHeight/2
        addBT.layer.cornerRadius = baseBTHeight/2
        editBT.layer.cornerRadius = baseBTHeight/2

    }
    
    func writeCategoryAppear() {
        let writeCategory = LPWriteCategoryController(nibName: "LPWriteCategoryController", bundle: nil)
        LPParentNavigationController.sharedInstance.pushViewController(writeCategory, animated: true)

    }
    
    func displayCategoryTable(categoryN: String, urls: [LPLinkModel]) {
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        
        let eachCategory = EachCategoryController(nibName: "EachCategoryController", bundle: nil)
        eachCategory.displayCategoryPage(categoryName: categoryN, categoryCount: "\(urls.count)", urls: tableItems)
        LPParentNavigationController.sharedInstance.pushViewController(eachCategory, animated: true)

    }
    
    func reloadCategory() {
        print("reload category")
        switch collectionStatus {
        case .ESEdit:
            collectionStatus = .ESFinished
            appearStatusEditLabel(constant: 0)
            baseBT.setImage(UIImage(named: "LPAddBT"), for: .normal)
            baseBT.setTitle(nil, for: .normal)
            originBbbButton()
            blackView.isHidden = false
        case .ESFinished:
            originBbbButton()
            blackView.isHidden = true
        }
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        self.mLPCategoryList.reloadData()
    }
    
    func addCategory() {
        self.listener?.startWriteCategory()
    }
   
    //MARK:- 뿅뿅뿅 버튼
    @IBOutlet weak var baseBT: UIButton!
    @IBOutlet weak var addBT: UIButton!
    @IBOutlet weak var editBT: UIButton!
    
    
    @IBOutlet weak var addBottom: NSLayoutConstraint!
    @IBOutlet weak var editBottom: NSLayoutConstraint!
    
    @IBAction func baseBTAction(_ sender: UIButton) {
        if self.addBottom.constant != 20 {
            switch collectionStatus {
            case .ESEdit:
                collectionStatus = .ESFinished
                appearStatusEditLabel(constant: 0)
                baseBT.setImage(UIImage(named: "LPAddBT"), for: .normal)
                baseBT.setTitle(nil, for: .normal)
                blackView.isHidden = true
            case .ESFinished:
                appearBbbButton()
                blackView.isHidden = false
            }
        } else {
            originBbbButton()
            blackView.isHidden = true
        }
    }
    
    func originBbbButton() { //이거 세개 겹쳐지게 하는거
        UIView.animate(withDuration: 0.2, animations: {
            self.addBottom.constant = -43
            self.editBottom.constant = -43
            self.layoutIfNeeded()
            self.baseBT.transform = .identity
        })
    }
    
    func appearBbbButton() {
        blackView.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.addBottom.constant = 20
            self.editBottom.constant = 20
            self.baseBT.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
            self.layoutIfNeeded()
        })
    }
    
    @IBAction func blackViewAction(_ sender: UIButton) {
        originBbbButton()
    }
    
    
    @IBAction func addBTAction(_ sender: UIButton) {
        blackView.isHidden = true
        let writeVC = LPWriteCategoryController(nibName: "LPWriteCategoryController", bundle: nil)
        writeVC.setBaseData(title: "카테고리 이름 입력", color: UIColor.clear)
        LPParentNavigationController.sharedInstance.pushViewController(writeVC, animated: true)
        
        originBbbButton()
    }
    
    var collectionStatus: LPEditStatus = .ESFinished
    
    @IBAction func editBTAction(_ sender: UIButton) {
        blackView.isHidden = true
        collectionStatus = .ESEdit
        baseBT.setImage(nil, for: .normal)
        baseBT.setTitle("완료", for: .normal)
        appearStatusEditLabel(constant: 40)
        originBbbButton()
    }
    
    func appearStatusEditLabel(constant: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.labelHeight.constant = constant
            self.layoutIfNeeded()
        })
    }
    
    
    
}
