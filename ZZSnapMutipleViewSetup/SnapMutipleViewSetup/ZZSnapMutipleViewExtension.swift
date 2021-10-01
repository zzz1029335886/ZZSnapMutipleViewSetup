//
//  ZZSnapMutipleViewExtension.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit


extension Array{
    fileprivate
    subscript (safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }
}

extension Array where Element: Comparable{
    var maxOne: Element{
        assert(self.count > 0)
        return reduce(self[0]) {
            Swift.max($0, $1)
        }
    }
}

extension UIView{
    
    /// 批量设置子视图
    /// - Parameters:
    ///   - views: subviews
    ///   - styles: style
    func zz_setupSubViews(_ views: [UIView], _ styles: ZZSnapMutipleViewSetup.Style...) {
        zz_setupSubViews(views, styles: styles)
    }
    
    func zz_setupSubViews(_ views: [UIView], styles: [ZZSnapMutipleViewSetup.Style]) {
        guard !views.isEmpty else {
            return
        }
        
        var showType: ZZSnapMutipleViewSetup.Style.LayoutType = .equalSize(1, nil)
        var horizontalSpace: CGFloat? = nil
        var verticalSpace: CGFloat? = nil
        var insets: ZZSnapMutipleViewSetup.Insets? = nil
        var alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = []
        var height: CGFloat?
        var width: CGFloat?
        
        for style in styles {
            switch style {
            case .showType(let type):
                showType = type
            case .horizontalSpace(let space):
                horizontalSpace = space
            case .verticalSpace(let space):
                verticalSpace = space
            case .insets(let top, let left, let bottom, let right):
                insets = .init(top: top, left: left, bottom: bottom, right: right)
            case .insetsModel(let _insets):
                insets = _insets
            case .alignment(let alignment):
                alignments.append(alignment)
            case .alignments(let _alignments):
                alignments.append(contentsOf: _alignments)
            case .height(let _height):
                height = _height
            case .width(let _width):
                width = _width
            }
        }
        
        if let height = height {
            self.snp.makeConstraints { make in
                make.height.equalTo(height)
            }
        }
        if let width = width {
            self.snp.makeConstraints { make in
                make.width.equalTo(width)
            }
        }
        
        switch showType{
        case .equalSize(let countInLine, let itemHeight, let bottomPriority):
            zz_setupSubViews(views: views, countInLine: countInLine, itemHeight: itemHeight, horizontalSpace: horizontalSpace ?? 0, verticalSpace: verticalSpace ?? 0, insets: insets, lastBottomPriority: bottomPriority)
            
        case .horizontal:
            zz_setupHorizontalSubViews(views: views, space: horizontalSpace, alignments: alignments, insets: insets)
            
        case .vertical:
            zz_setupVerticalSubViews(views: views, space: verticalSpace, alignments: alignments, insets: insets)
        }
    }
    
    /// 使用snp批量设置子视图的约束，最后一个子视图的高度为自己的高度，子控件宽度相同
    /// - Parameters:
    ///   - subViews: 子视图列表
    ///   - countInLine: 每行个数，当每行数量为：1时，效果就是垂直布局
    ///   - horizontalSpace: 横向间距
    ///   - verticalSpace: 纵向间距
    ///   - insets: 内边距
    ///   - itemHeight: 每个高度，空表示自适应
    ///   - lastBottomPriority: 底部约束
    func zz_setupSubViews(
        views subViews: [UIView],
        countInLine: Int = 2,
        itemHeight: CGFloat? = nil,
        horizontalSpace: CGFloat = 0,
        verticalSpace: CGFloat = 0,
        insets: ZZSnapMutipleViewSetup.Insets? = .zero,
        lastBottomPriority: ConstraintPriority = .required
    ) {
        let view = self
        let paddingX = horizontalSpace
        let paddingY = verticalSpace
        
        var paddingX1 = paddingX
        var paddingY1 = paddingY
        
        var left = view.snp.left
        var width = view.snp.width
        var height = view.snp.height
        var top = view.snp.top
        
        let leftMargin: CGFloat = insets?.left ?? 0
        let topMargin: CGFloat = insets?.top ?? 0
        let rightMargin: CGFloat = insets?.right ?? 0
        let bottomMargin: CGFloat = insets?.bottom ?? 0
        
        for (index, subview) in subViews.enumerated() {
            subview.removeFromSuperview()
            view.addSubview(subview)
            
            /// 每行第一个
            if index % countInLine == 0{
                subview.snp.makeConstraints { (m) in
                    m.left.equalToSuperview().inset(leftMargin)
                    m.top.equalTo(top).offset((index == 0 ? topMargin : 0) + (index == 0 ? 0 : paddingY))
                    m.width.equalToSuperview()
                        .dividedBy(countInLine)
                        .offset(-(leftMargin + rightMargin + paddingX1 * CGFloat(countInLine - 1)) / CGFloat(countInLine) )
                }
                
                if let height = itemHeight {
                    subview.snp.makeConstraints { m in
                        m.height.equalTo(height)
                    }
                }
                
                width = subview.snp.width
                height = subview.snp.height
                left = subview.snp.right
                
                /// 每行一个时，换行
                if countInLine == 1 {
                    top = subview.snp.bottom
                    /// 最多一行时
                }else {
                    top = subview.snp.top
                }
                
                paddingY1 = 0
                
            }else {
                
                subview.snp.makeConstraints { (m) in
                    m.width.equalTo(width)
                    m.height.equalTo(height)
                    m.top.equalTo(top).offset(paddingY1)
                    m.left.equalTo(left).offset(paddingX1)
                }
                
                left = subview.snp.right
                
                /// 换行
                if (index + 1) % countInLine == 0{
                    top = subview.snp.bottom
                }else{
                    top = subview.snp.top
                }
                
                paddingY1 = 0
                paddingX1 = paddingX
            }
            
            if index == subViews.count - 1 {
                subview.snp.makeConstraints { (m) in
                    m.bottom.equalToSuperview().inset(bottomMargin).priority(lastBottomPriority)
                }
            }
        }
    }
    
    /// 使用snp批量设置垂直子视图，每个之间平均距离相同，并居中
    /// - Parameter subViews: 子视图列表
    /// - Parameter space: 垂直间距，不设为自适应
    /// - Parameter insets: 内边距
    /// - Parameter alignments: 对齐方式
    func zz_setupVerticalSubViews(
        views subViews: [UIView],
        space: CGFloat? = nil,
        alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = [],
        insets: ZZSnapMutipleViewSetup.Insets? = .zero)
    {
        if subViews.count == 0 {
            return
        }
        
        var spaceViews: [UIView]? = nil
        if space != 0 {
            spaceViews = (0..<subViews.count - 1).compactMap { (index) -> UIView in
                let view = UIView()
                view.tag = index
                self.addSubview(view)
                return view
            }
        }
        
        var top = self.snp.top
        var firstSpaceView : UIView?
        var lastFlexView: ZZSnapMutipleViewSetupFlex?
        
        for (index, subView) in subViews.enumerated() {
            addSubview(subView)
            
            if let scrollView = subView as? UIScrollView {
                scrollView.snp.makeConstraints { make in
                    make.width.equalToSuperview().offset(0).priority(.high)
                }
            }
            zz_setupSubViewAlignments(subView, alignments: alignments, isVertical: true, insets: insets, lastFlexView: &lastFlexView)
            
            if index == 0 {
                subView.snp.makeConstraints { (m) in
                    m.top.equalToSuperview().inset(insets?.top ?? 0)
                }
            }else {
                subView.snp.makeConstraints { (m) in
                    m.top.equalTo(top)
                }
            }
            
            if index == subViews.count - 1{
                if let bottom = insets?.bottom {
                    subView.snp.makeConstraints { (m) in
                        m.bottom.equalToSuperview().inset(bottom)
                    }
                }else{
                    subView.snp.makeConstraints { (m) in
                        m.bottom.equalToSuperview().priority(.low)
                    }
                }
            }
            
            if let spaceView = spaceViews?[safe: index]{
                if index == 0{
                    if let space = space {
                        spaceView.snp.makeConstraints { (m) in
                            m.height.equalTo(space)
                        }
                    }
                    firstSpaceView = spaceView
                }else if let firstSpaceView = firstSpaceView{
                    spaceView.snp.makeConstraints { (m) in
                        m.height.equalTo(firstSpaceView)
                    }
                }
                spaceView.snp.makeConstraints { (m) in
                    m.top.equalTo(subView.snp.bottom)
                    m.centerX.equalToSuperview()
                    m.left.equalToSuperview()
                }
                top = spaceView.snp.bottom
            }else{
                top = subView.snp.bottom
            }
        }
    }
    
    /// 使用snp批量设置水平子视图，每个之间平均距离相同，并居中
    /// - Parameter subViews: 子视图列表
    /// - Parameter space: 间距宽度，不设为自适应
    /// - Parameter insets: 内边距
    /// - Parameter alignments: 对齐方式
    func zz_setupHorizontalSubViews(
        views subViews: [UIView],
        space: CGFloat? = nil,
        alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = [],
        insets: ZZSnapMutipleViewSetup.Insets? = .zero
    ) {
        if subViews.count == 0 {
            return
        }
        
        var spaceViews: [UIView]? = nil
        if space != 0 {
            spaceViews = (0..<subViews.count - 1).compactMap { (index) -> UIView in
                let view = UIView()
                view.tag = index
                self.addSubview(view)
                return view
            }
        }
        
        var left = self.snp.left
        var firstSpaceView : UIView?
        var lastFlexView: ZZSnapMutipleViewSetupFlex?
        
        for (index, subView) in subViews.enumerated() {
            addSubview(subView)
            
            if let scrollView = subView as? UIScrollView {
                scrollView.snp.makeConstraints { make in
                    make.height.equalToSuperview().offset(0).priority(.high)
                }
            }
            zz_setupSubViewAlignments(subView, alignments: alignments, isVertical: false, insets: insets, lastFlexView: &lastFlexView)
            
            if index == 0 {
                subView.snp.makeConstraints { (m) in
                    m.left.equalToSuperview().offset((insets?.left ?? 0))
                }
            }else {
                subView.snp.makeConstraints { (m) in
                    m.left.equalTo(left)
                }
            }
            
            if index == subViews.count - 1{
                if let right = insets?.right {
                    subView.snp.makeConstraints { (m) in
                        m.right.equalToSuperview().inset(right)
                    }
                }else{
                    subView.snp.makeConstraints { (m) in
                        m.right.equalToSuperview().priority(.low)
                    }
                }
            }
            
            if let spaceView = spaceViews?[safe: index]{
                if index == 0{
                    if let space = space {
                        spaceView.snp.makeConstraints { (m) in
                            m.width.equalTo(space)
                        }
                    }
                    firstSpaceView = spaceView
                }else if let firstSpaceView = firstSpaceView{
                    spaceView.snp.makeConstraints { (m) in
                        m.width.equalTo(firstSpaceView)
                    }
                }
                spaceView.snp.makeConstraints { (m) in
                    m.left.equalTo(subView.snp_right)
                    m.centerY.equalToSuperview()
                    m.top.equalToSuperview()
                }
                left = spaceView.snp.right
            }else{
                left = subView.snp.right
            }
        }
    }
    
    func zz_setupSubViewAlignments(
        _ subView: UIView,
        alignments: [ZZSnapMutipleViewSetup.Style.Alignment],
        isVertical: Bool? = nil,
        insets: ZZSnapMutipleViewSetup.Insets? = .zero,
        isMustAlignment: Bool = false,
        lastFlexView: inout ZZSnapMutipleViewSetupFlex?
    ) {
        
        if !isMustAlignment, specialConstraints(view: subView, isVertical: isVertical, lastFlexView: &lastFlexView){
            return
        }
        
        for alignment in alignments {
            switch alignment {
            case .equal(let insets):
                if let top = insets.top {
                    zz_setupSubViewAlignments(subView, alignments: [.top(top)], isVertical: isVertical, insets: nil, isMustAlignment: isMustAlignment, lastFlexView: &lastFlexView)
                }
                if let left = insets.left {
                    zz_setupSubViewAlignments(subView, alignments: [.left(left)], isVertical: isVertical, insets: nil, isMustAlignment: isMustAlignment, lastFlexView: &lastFlexView)
                }
                if let right = insets.right {
                    zz_setupSubViewAlignments(subView, alignments: [.right(right)], isVertical: isVertical, insets: nil, isMustAlignment: isMustAlignment, lastFlexView: &lastFlexView)
                }
                if let bottom = insets.bottom {
                    zz_setupSubViewAlignments(subView, alignments: [.bottom(bottom)], isVertical: isVertical, insets: nil, isMustAlignment: isMustAlignment, lastFlexView: &lastFlexView)
                }
            case .top(let padding):
                if isVertical == true {
                    
                }else{
                    let topPadding = (insets?.top ?? 0) + padding
                    
                    subView.snp.makeConstraints { (m) in
                        m.top.equalToSuperview().inset(topPadding)
                    }
                    
                    if let scrollView = subView as? UIScrollView {
                        scrollView.contentSize.height += topPadding
                        scrollView.snp.updateConstraints { make in
                            make.height.equalToSuperview().offset(-scrollView.contentSize.height).priority(.high)
                        }
                    }
                    
                }
            case .bottom(let padding):
                if isVertical == true {
                    
                }else{
                    let bottomPadding = (insets?.bottom ?? 0) + padding
                    
                    subView.snp.makeConstraints { (m) in
                        m.bottom.equalToSuperview().inset(bottomPadding)
                    }
                    
                    if let scrollView = subView as? UIScrollView {
                        scrollView.contentSize.height += bottomPadding
                        scrollView.snp.updateConstraints { make in
                            make.height.equalToSuperview().offset(-scrollView.contentSize.height).priority(.high)
                        }
                    }
                }
            case .center(let padding):
                if let isVertical = isVertical {
                    if isVertical {
                        subView.snp.makeConstraints { (m) in
                            m.centerX.equalToSuperview().offset(padding)
                        }
                    } else {
                        subView.snp.makeConstraints { (m) in
                            m.centerY.equalToSuperview().offset(padding)
                        }
                    }
                }else{
                    subView.snp.makeConstraints { (m) in
                        m.center.equalToSuperview().offset(padding)
                    }
                }
            case .left(let padding):
                if isVertical == false {
                    
                }else{
                    let leftPadding = (insets?.left ?? 0) + padding
                    subView.snp.makeConstraints { (m) in
                        m.left.equalToSuperview().inset(leftPadding)
                    }
                    if let scrollView = subView as? UIScrollView {
                        scrollView.contentSize.width += leftPadding
                        scrollView.snp.updateConstraints { make in
                            make.width.equalToSuperview().offset(-scrollView.contentSize.width).priority(.high)
                        }
                    }
                }
            case .right(let padding):
                if isVertical == false {
                    
                }else{
                    let rightPadding = (insets?.right ?? 0) + padding
                    
                    subView.snp.makeConstraints { (m) in
                        m.right.equalToSuperview().inset(rightPadding)
                    }
                    
                    if let scrollView = subView as? UIScrollView {
                        scrollView.contentSize.width += rightPadding
                        scrollView.snp.updateConstraints { make in
                            make.width.equalToSuperview().offset(-scrollView.contentSize.width).priority(.high)
                        }
                    }
                }
            }
        }
    }
    
    
    fileprivate
    func specialConstraints(
        view subView: UIView,
        isVertical: Bool?,
        lastFlexView: inout ZZSnapMutipleViewSetupFlex?
    ) -> Bool{
        var isBool = false
        
        if let containView = subView as? ZZSnapMutipleViewSetupContain{
            isBool = true
            containView.setup()
        }
        
        if let alignmentView = subView as? ZZSnapMutipleViewSetupAlignment {
            isBool = true
            zz_setupSubViewAlignments(alignmentView, alignments: alignmentView.alignments, isVertical: isVertical, isMustAlignment: true,  lastFlexView: &lastFlexView)
        }
        
        if let flexView = subView as? ZZSnapMutipleViewSetupFlex{
            isBool = true
            if let isVertical = isVertical {
                if isVertical {
                    flexView.snp.makeConstraints { (m) in
                        m.width.lessThanOrEqualToSuperview().priority(.high)
                    }
                    lastFlexView?.snp.makeConstraints({ make in
                        make.height.equalTo(flexView)
                    })
                }else{
                    flexView.snp.makeConstraints { (m) in
                        m.height.lessThanOrEqualToSuperview().priority(.high)
                    }
                    lastFlexView?.snp.makeConstraints({ make in
                        make.width.equalTo(flexView)
                    })
                }
            }else{
                flexView.snp.makeConstraints { make in
                    make.size.lessThanOrEqualToSuperview().priority(.high)
                }
            }
            
            lastFlexView = flexView
        }
        
        if let spaceView = subView as? ZZSnapMutipleViewSetupSpace{
            isBool = true
            if let zz_width = spaceView.zz_width {
                spaceView.snp.makeConstraints { make in
                    make.width.equalTo(zz_width)
                }
            }
            if let zz_height = spaceView.zz_height {
                spaceView.snp.makeConstraints { make in
                    make.height.equalTo(zz_height)
                }
            }
        }
        
        return isBool
    }
}
