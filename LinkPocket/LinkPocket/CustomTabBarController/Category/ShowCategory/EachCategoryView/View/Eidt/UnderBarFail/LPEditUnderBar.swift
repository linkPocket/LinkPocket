//
//  LPEidtUnderar.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 9. 5..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPEditUnderBar: UIView {

    @IBOutlet weak var countLabel: UILabel!
    var contentView: UIView?
    var view: UIView?
    
    override func awakeFromNib() {
        print("왜안되지")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        view = loadViewFromNib()
//        view?.frame = self.bounds
//        view?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
//        addSubview(view!)
//
//        guard let view = loadViewFromNib() else { return }
//        view.frame = self.bounds
//        self.addSubview(view)
//        contentView = view
//
//    }
//
//
//    func loadViewFromNib() -> UIView? {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "LPEditUnderBar", bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//
//        return view
//
//        countLabel.layer.cornerRadius = countLabel.bounds.height/2
//        countLabel.layer.borderWidth = 4
//        countLabel.layer.borderColor = UIColor.colorFromRGB(0x008EFF).cgColor
//
//        print("이건되는건가2")
//    }
    
    @IBAction func moveBtAction(_ sender: UIButton) {
        print("옮겨집니다")
    }
    
    @IBAction func deleteBtAction(_ sender: UIButton) {
        print("삭제됩니다.")
    }
}
