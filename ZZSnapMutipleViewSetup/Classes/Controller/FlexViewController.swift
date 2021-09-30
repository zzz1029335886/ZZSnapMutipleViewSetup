//
//  FlexViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

class FlexViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.zz_setupSubViews(
            [
                getTitleLabel("垂直伸缩"),
                view0,
                getTitleLabel("水平伸缩"),
                view1
            ],
            .showType(.vertical),
            .insets(top: 108, left: 20, bottom: nil, right: 40),
            .alignment(.center()),
            .alignment(.left(10))
        )
                
        view0.zz_setupSubViews(
            [
                getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20),
                .zz_flexView,
                getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20)
            ],
            .showType(.vertical),
            .alignment(.left(10)),
            .alignment(.right(10)),
            .height(200)
        )
        
        view1.zz_setupSubViews(
            [
                getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20),
                .zz_flexView,
                getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20)
            ],
            .showType(.horizontal),
            .alignment(.top(10)),
            .alignment(.bottom(10)),
            .height(100)
        )
    }
    

}
