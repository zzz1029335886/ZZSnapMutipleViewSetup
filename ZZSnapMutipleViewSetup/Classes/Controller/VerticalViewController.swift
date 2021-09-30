//
//  VerticalViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

class VerticalViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.zz_setupSubViews(
            [getTitleLabel("左对齐:10,第2个右对齐并加内边距").zz_flexView(insets: .init(all: 10)), view0, getTitleLabel("垂直对齐"), view1, getTitleLabel("右对齐10"), view2],
            .showType(.vertical),
            .insets(top: 108, left: 20, bottom: nil, right: 20),
            .alignment(.center(0)), .alignment(.left(10))
        )
        
        var views0 = getRandomSizeViews(
            count: 5,
            maxWidth: kScreenWidth * 0.5,
            minWidth: kScreenWidth * 0.25,
            maxHeight: 50,
            minHeight: 20
        )
        views0[2] = .zz_alignmentView(views0[2], insets: .init(all: 10), alignments: .right(10))
        
        view0.zz_setupSubViews(
            views0,
            .showType(.vertical),
            .alignment(.left(10)),
            .verticalSpace(5)
        )
        
        view1.zz_setupSubViews(
            getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
            .showType(.vertical),
            .alignment(.center())
        )
        
        view2.zz_setupSubViews(
            getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
            .showType(.vertical),
            .alignment(.right(10))
        )
        
    }
    
}
