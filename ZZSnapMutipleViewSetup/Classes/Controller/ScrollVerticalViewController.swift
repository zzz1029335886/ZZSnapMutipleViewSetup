//
//  ScrollVerticalViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

class ScrollVerticalViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollViews =  (0...4).compactMap{
            index -> UIView in
            return .zz_getViewWithSubViews(
                UIScrollView.self,
                views: getRandomSizeViews(count: 30),
                .showType(.vertical),
                .width(100)
            )
        }
        
        scrollView.zz_setupSubViews(
            scrollViews,
            .showType(.horizontal),
            .alignments([.top(10), .right(10)])
        )
        
    }
}
