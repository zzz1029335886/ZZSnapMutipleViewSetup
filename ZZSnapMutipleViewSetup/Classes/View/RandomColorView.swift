//
//  RandomColorView.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

class RandomColorView: UIView, ZZSnapMutipleViewSetupConstraint {
    var zz_topConstraint: Constraint?
    var zz_bottomConstraint: Constraint?
    var zz_leftConstraint: Constraint?
    var zz_rightConstraint: Constraint?
        
    var isSelected = false{
        didSet{
            if isSelected {
                self.layer.borderWidth = 4
                self.layer.borderColor = UIColor.randomColor.cgColor
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .randomColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
