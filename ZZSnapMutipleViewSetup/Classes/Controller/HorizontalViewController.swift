//
//  HorizontalViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

class HorizontalViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.zz_setupSubViews(
            [
                getTitleLabel("下对齐10"),
                view0,
                getTitleLabel("中对齐"),
                view1,
                getTitleLabel("上对齐20"),
                view2
            ],
            .showType(.horizontal),
            .alignment(.center())
        )
        
        view0.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
            .showType(.horizontal),
            .alignment(.bottom(10)),
            .height(100)
        )
        
        view1.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
            .showType(.horizontal),
            .alignment(.center()),
            .height(100)
        )
                
        view2.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
            .showType(.horizontal),
            .alignment(.top(20)),
            .height(100)
        )
    }
    
}
