//
//  MoreViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

class MoreViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.zz_setupSubViews(
            [
                .zz_spaceContainView(getTitleLabel("spaceView：空间view，指定宽度和高度，常用于占位")),
                .zz_spaceView(width: 150, height: 100).randomBackgroundColor,
                .zz_spaceContainView(
                    getOneRandomSizeView(maxWidth: 100, minWidth: 100, maxHeight: 50, minHeight: 50),
                    width: 100,
                    height: 50
                ),
                .zz_alignmentContainView(
                    getTitleLabel("alignmentView：对齐view，相当父view的对齐方式"),
                    alignments: .insets()
                ),
                .zz_alignmentContainView(
                    getOneRandomSizeView(maxWidth: 100, minWidth: 100, maxHeight: 50, minHeight: 50),
                    alignments: .right(10)
                ).zz_insets(insets: .init(all: 10)).randomBackgroundColor,
                .zz_alignmentContainView(
                    getOneRandomSizeView(maxWidth: 100, minWidth: 100, maxHeight: 50, minHeight: 50),
                    alignments: .center()
                ).zz_insets(insets: .init(all: 10)).randomBackgroundColor
            ],
            .showType(.vertical),
            .alignment(.center()),
            .verticalSpace(0),
            .insetsModel(insets: .init(top: 88))
        )
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
}
