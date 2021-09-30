//
//  MoreViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

class MoreViewController: ViewController {
    lazy var views: [UIView] = [
        UIView.zz_getViewWithSubViews(getRandomSizeViews(count: 30), .showType(.vertical), .alignment(.left(10)), .width(100), .horizontalSpace(nil)),
        .zz_flexView,
        UIView.zz_getViewWithSubViews(getRandomSizeViews(count: 30), .showType(.vertical), .alignment(.center()), .width(100), .horizontalSpace(nil)),
        .zz_flexView,
        UIView.zz_getViewWithSubViews(getRandomSizeViews(count: 30), .showType(.vertical), .alignment(.right(10)), .width(100), .horizontalSpace(nil)),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.zz_setupSubViews(
            views,
            .showType(.horizontal),
            .horizontalSpace(nil)
        )
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
}
