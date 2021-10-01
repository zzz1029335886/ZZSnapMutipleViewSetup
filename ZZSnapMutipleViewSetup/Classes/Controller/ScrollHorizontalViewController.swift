//
//  ScrollHorizontalViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

class ScrollHorizontalViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollViews =  (0...10).compactMap{
            index -> UIView in
            return .zz_getViewWithSubViews(
                UIScrollView.self,
                views: getRandomSizeViews(count: 10),
                .showType(.horizontal),
                .height(100)
            )
        }
        
        scrollView.zz_setupSubViews(
            scrollViews,
            .showType(.vertical),
            .alignments([.left(), .right(10)]),
            .insetsModel(insets: .init(all: 10))
        )
        
    }

}
