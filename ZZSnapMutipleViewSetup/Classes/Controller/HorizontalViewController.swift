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
                getTitleLabel("下对齐10").zz_alignmentView(alignments: .bottom(), .right(), .left()).zz_spaceView(width: nil, height: 100).zz_insets(insets: .init(all: 10)),
                .zz_getViewWithSubViews([getTitleLabel("下对齐10")], .alignment(.bottom()), .showType(.horizontal), .height(100)),
                view0,
                getTitleLabel("中对齐").zz_alignmentView(alignments: .equal(.init(horizontal: 10, vertical: 10)), .center(0)).zz_spaceView(width: nil, height: 100),
                .zz_getViewWithSubViews([getTitleLabel("中对齐")], .alignment(.center()), .showType(.horizontal), .height(100), .insetsModel(insets: .init(all: 10))),
                view1,
                getTitleLabel("上对齐20"),
                view2
            ],
            .showType(.horizontal),
            .alignment(.top())
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
