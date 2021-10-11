//
//  VerticalViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit
import SnapKit

class VerticalViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.zz_setupSubViews(
            [
                getTitleLabel("左对齐:10,第2个右对齐并加内边距").zz_flexView.zz_insets(insets: .init(all: 10)),
                view0,
                getTitleLabel("垂直对齐"),
                view1,
                getTitleLabel("右对齐10"),
                view2
            ],
            .showType(.vertical),
            .insets(top: nil, left: 20, bottom: 100, right: 20),
            .alignment(.center(0)), .alignment(.left(10))
        )
        
        var views0 = getRandomSizeViews(
            count: 5,
            maxWidth: kScreenWidth * 0.5,
            minWidth: kScreenWidth * 0.25,
            maxHeight: 50,
            minHeight: 20
        )
        let contentView = views0[2]
        contentView.gestureRecognizers?.forEach({ ges in
            contentView.removeGestureRecognizer(ges)
        })
        
        let containView = UIView.zz_alignmentContainView(getOneRandomSizeView(), alignments: .right(10))
        containView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView(_:))))
        views0[2] = containView
        
        view0.zz_setupSubViews(
            views0,
            .showType(.vertical),
            .alignment(.left(10)),
            .verticalSpace(5)
        )
        
        let views1 = getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20)
        view1.zz_setupSubViews(
            views1,
            .showType(.vertical),
            .alignment(.center(0))
        )
        
        view2.zz_setupSubViews(
            getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
            .showType(.vertical),
            .alignment(.right(10))
        )
        
    }
        
    @objc
    override func plus() {
        padding += 20
        UIView.animate(withDuration: 0.25) {
            self.selectedView?.zz_rightConstraint?.update(offset: self.padding)
            self.scrollView.layoutIfNeeded()
        }
    }
    
    @objc
    override func reduce() {
        padding -= 20
        UIView.animate(withDuration: 0.25) {
            self.selectedView?.zz_rightConstraint?.update(offset: self.padding)
            self.scrollView.layoutIfNeeded()
        }
    }
}

