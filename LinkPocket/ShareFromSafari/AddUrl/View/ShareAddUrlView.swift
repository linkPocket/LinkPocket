//
//  ShareAddUrlView.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol ShareAddUrlViewDelegate {
    func floatingBtnClicked()
}

class ShareAddUrlView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingBtn: UIButton!
    
    var delegate: ShareAddUrlViewDelegate?
    
    var tableViewAdapter: ShareAddUrlTableViewAdapter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createImageView()
        createTableViewAdapter()
        createFloatingBtn()
    }
    
    func createFloatingBtn() {
        self.floatingBtn.layer.cornerRadius = 25
        self.floatingBtn.tintColor = .white
        self.floatingBtn.setImage(UIImage(named: "addFolder.png"), for: .normal)
        self.floatingBtn.addTarget(self, action: #selector(floatingBtnClicked), for: .touchDown)
    }
    
    func createTableViewAdapter() {
        self.tableViewAdapter = ShareAddUrlTableViewAdapter()
        self.tableView.delegate = self.tableViewAdapter
        self.tableView.dataSource = self.tableViewAdapter
        
        let nibCell = UINib(nibName: (self.tableViewAdapter?.identifier)!, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: (self.tableViewAdapter?.identifier)!)
    }
    
    func createImageView() {
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.backgroundColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1)
        self.imageView.layer.borderColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1).cgColor
    }
    
    @objc func floatingBtnClicked() {
        self.delegate?.floatingBtnClicked()
    }
}
