//
//  RandomColorView.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

class RandomColorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .randomColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
