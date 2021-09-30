//
//  WidgetViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

class WidgetViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.zz_setupSubViews([view0, view1], .showType(.vertical), .alignment(.left(10)), .alignment(.right(10)), .verticalSpace(20), .insets(top: 88))
        
        view0.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
            .showType(.horizontal),
            .alignment(.bottom(10)),
            .height(100)
        )
        
        
        view1.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30).compactMap{ $0.zz_widget(CGFloat($0.tag + 1)) },
            .showType(.horizontal),
            .alignment(.bottom(10)),
            .horizontalSpace(0),
            .height(100)
        )
        
    }
    

}
