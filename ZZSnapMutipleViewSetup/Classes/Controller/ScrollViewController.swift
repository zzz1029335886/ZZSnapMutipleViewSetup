//
//  ScrollViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/10/1.
//

import UIKit

class ScrollViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollViews =  (0...30).compactMap{
            index -> UIView in
            return .zz_getViewWithSubViews(
                UIView.self,
                views: getRandomSizeViews(count: 3),
                .showType(.horizontal)
            )
        }
                
        scrollView.zz_setupSubViews(
            scrollViews,
            .showType(.vertical),
            .alignment(.insets(.init(all: 10)))
//            .alignments([.left(10), .right(10)]),
//            .insetsModel(insets: .init(all: 10))
        )
        
    }
    
}
