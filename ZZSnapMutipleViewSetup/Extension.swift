//
//  Extension.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

extension UIColor{
    class var randomColor: UIColor{
        get{
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
extension UIView{
    var randomBackgroundColor: Self{
        self.backgroundColor = .randomColor
        return self
    }
    
}
