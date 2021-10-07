//
//  ZZSnapMutipleViewSetup.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit
import SnapKit

struct ZZSnapMutipleViewSetup {
    struct Insets {
        static let zero: Insets = .init(top: 0, left: 0, bottom: 0, right: 0)
        static func with(edgeInsets: UIEdgeInsets) -> Insets {
            return .init(top: edgeInsets.top, left: edgeInsets.left, bottom: edgeInsets.bottom, right: edgeInsets.right)
        }
        
        let top: CGFloat?
        let left: CGFloat?
        let bottom: CGFloat?
        let right: CGFloat?
        
        init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
            self.top = top
            self.left = left
            self.right = right
            self.bottom = bottom
        }
        
        init(all: CGFloat?) {
            top = all
            left = all
            bottom = all
            right = all
        }
        
        init(horizontal: CGFloat? = nil, vertical: CGFloat? = nil) {
            top = vertical
            bottom = vertical
            right = horizontal
            left = horizontal
        }
        
        var edgeInsets: UIEdgeInsets{
            return .init(top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0)
        }
        
        
        
    }
    
    enum Style {
        enum LayoutType {
            case horizontal
            case vertical
            
            /// 每个子view的size一样，自适应宽度
            /// countInLine：每行个数，默认1，为1时效果是垂直布局
            /// itemHeight：每个view的高度，默认为空，为空表示自适应
            /// lastBottomPriority：最后一个子view与父的约束，默认为required，为required可约束当前view的高度
            case equalSize(
                _ countInLine: Int = 1,
                _ itemHeight: CGFloat? = nil,
                _ lastBottomPriority: ConstraintPriority = .required
            )
        }
        
        enum Alignment {
            case left(_ padding: CGFloat = 0)
            case right(_ padding: CGFloat = 0)
            case top(_ padding: CGFloat = 0)
            case bottom(_ padding: CGFloat = 0)
            case center(_ padding: CGFloat = 0)
            case insets(_ insets: ZZSnapMutipleViewSetup.Insets = .zero)
        }
        
        case showType(_ type: LayoutType)
        
        /// nil is autoSpace, default is nil
        case space(_ space: CGFloat? = 0)
        /// nil is autoSpace, default is nil
        case horizontalSpace(_ space: CGFloat? = 0)
        /// nil is autoSpace, default is nil
        case verticalSpace(_ space: CGFloat? = 0)
        
        /// Invalid for 'showType' is 'equalSize'
        case alignment(_ alignment: Alignment)
        /// Invalid for 'showType' is 'equalSize'
        case alignments(_ alignments: [Alignment])
        
        /// height for self
        case height(_ height: CGFloat)
        /// width for self
        case width(_ width: CGFloat)
        
        /// 'insets' with case 'insetsModel', The last value is valid
        case insets(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil)
        /// 'insetsModel' with case 'insets', The last value is valid
        case insetsModel(insets: ZZSnapMutipleViewSetup.Insets)
    }
    
    class FlexView: UIView, ZZSnapMutipleViewSetupFlex {
        var insets: ZZSnapMutipleViewSetup.Insets = .zero
        var alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = []
        var zz_contentView: UIView?
    }
    class SpaceView: UIView, ZZSnapMutipleViewSetupSpace {
        var isIgnore: Bool = true
        var alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = []
        var insets: ZZSnapMutipleViewSetup.Insets = .zero
        var zz_contentView: UIView?
        var zz_width: CGFloat?
        var zz_height: CGFloat?
    }
    class AlignmentView: UIView, ZZSnapMutipleViewSetupAlignment {
        var insets: ZZSnapMutipleViewSetup.Insets = .zero
        var zz_contentView: UIView?
        var alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = []
    }
}

protocol ZZSnapMutipleViewSetupContain: UIView {
    var zz_contentView: UIView? {set get}
    var insets: ZZSnapMutipleViewSetup.Insets {set get}
    func setup()
}

extension ZZSnapMutipleViewSetupContain{
    func setup() {
        setupContain()
    }
    
    fileprivate
    func setupContain() {
        guard let zz_contentView = zz_contentView else { return }
        addSubview(zz_contentView)
        zz_contentView.snp.makeConstraints { make in
            make.edges.equalTo(insets.edgeInsets)
        }
    }
    
    func judgContainView() {
        if let containView = zz_contentView as? ZZSnapMutipleViewSetupContain {
            containView.setup()
        }
    }
    
    func zz_insets(
        insets: ZZSnapMutipleViewSetup.Insets = .zero
    ) -> Self{
        self.insets = insets
        return self
    }
}

/// 空间view，指定宽度和高度，常用于占位
protocol ZZSnapMutipleViewSetupSpace: ZZSnapMutipleViewSetupAlignment {
    /// 是否忽略insets，alignment
    var isIgnore: Bool {set get}
    /// 宽度
    var zz_width: CGFloat? {set get}
    /// 高度
    var zz_height: CGFloat? {set get}
}

extension ZZSnapMutipleViewSetupSpace{
    func setup() {
        setupContain()
        
        if let zz_width = zz_width {
            snp.makeConstraints { make in
                make.width.equalTo(zz_width)
            }
        }
        if let zz_height = zz_height {
            snp.makeConstraints { make in
                make.height.equalTo(zz_height)
            }
        }
    }
}

/// 伸缩view，忽视alignment
protocol ZZSnapMutipleViewSetupFlex: ZZSnapMutipleViewSetupAlignment {}
protocol ZZSnapMutipleViewSetupAlignment: ZZSnapMutipleViewSetupContain {
    var alignments: [ZZSnapMutipleViewSetup.Style.Alignment]{ set get }
}
extension ZZSnapMutipleViewSetupAlignment{
    func zz_alignments(
        alignments: ZZSnapMutipleViewSetup.Style.Alignment...
    ) -> Self{
        self.alignments = alignments
        return self
    }
}

//private struct AssociatedKeys {
//    static var kZZSnapMutipleViewSetupWidget = "kZZSnapMutipleViewSetupWidget"
//}
//
//extension UIView{
//    var zz_widget: CGFloat? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.kZZSnapMutipleViewSetupWidget) as? CGFloat
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.kZZSnapMutipleViewSetupWidget, newValue, .OBJC_ASSOCIATION_ASSIGN)
//        }
//    }
//}

extension UIView{
    
    //    func zz_widget(_ widget: CGFloat) -> Self {
    //        self.zz_widget = widget
    //        return self
    //    }
    
    static var zz_flexView: ZZSnapMutipleViewSetup.FlexView{
        return ZZSnapMutipleViewSetup.FlexView()
    }
    
    var zz_flexView: ZZSnapMutipleViewSetup.FlexView{
        return .zz_flexContainView(self)
    }
    
    static func zz_flexContainView(
        _ view: UIView
    ) -> ZZSnapMutipleViewSetup.FlexView{
        let flexView = zz_flexView
        flexView.zz_contentView = view
        flexView.judgContainView()
        return flexView
    }
    
    fileprivate
    static func zz_alignmentContainView(
        _ view: UIView,
        alignments: [ZZSnapMutipleViewSetup.Style.Alignment]
    ) -> ZZSnapMutipleViewSetup.AlignmentView {
        
        let alignmentView = ZZSnapMutipleViewSetup.AlignmentView()
        alignmentView.alignments = alignments
        alignmentView.zz_contentView = view
        alignmentView.judgContainView()
        return alignmentView
    }
    
    func zz_alignmentView(
        alignments: ZZSnapMutipleViewSetup.Style.Alignment...
    ) -> ZZSnapMutipleViewSetup.AlignmentView{
        return .zz_alignmentContainView(self, alignments: alignments)
    }
    
    static func zz_alignmentContainView(
        _ view: UIView,
        alignments: ZZSnapMutipleViewSetup.Style.Alignment...
    ) -> ZZSnapMutipleViewSetup.AlignmentView {
        return .zz_alignmentContainView(view, alignments: alignments)
    }
    
    
    
    static func zz_spaceView(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isIgnore: Bool = true
    ) -> ZZSnapMutipleViewSetup.SpaceView{
        let spaceView = ZZSnapMutipleViewSetup.SpaceView()
        spaceView.zz_width = width
        spaceView.zz_height = height
        spaceView.isIgnore = isIgnore
        return spaceView
    }
    
    func zz_spaceView(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isIgnore: Bool = true
    ) -> ZZSnapMutipleViewSetup.SpaceView{
        return .zz_spaceContainView(self, width: width, height: height, isIgnore: isIgnore)
    }
    
    static func zz_spaceContainView(
        _ view: UIView,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isIgnore: Bool = true
    ) -> ZZSnapMutipleViewSetup.SpaceView {
        let spaceView = zz_spaceView(width: width, height: height, isIgnore: isIgnore)
        spaceView.zz_contentView = view
        spaceView.judgContainView()
        return spaceView
    }
}

extension UIView{
    /// 批量设置子视图
    /// - Parameters:
    ///   - views: subviews
    ///   - styles: style
    static func zz_getViewWithSubViews(_ views: [UIView], _ styles: ZZSnapMutipleViewSetup.Style...) -> UIView{
        let view = UIView()
        view.zz_setupSubViews(views, styles: [.insetsModel(insets: .init(all: .zero))] + styles)
        return view
    }
    
    /// 批量设置子视图
    /// - Parameters:
    ///   - views: subviews
    ///   - styles: style
    static func zz_getViewWithSubViews<T: UIView>(_ viewClass: T.Type,  views: [UIView], _ styles: ZZSnapMutipleViewSetup.Style...) -> T{
        let view = viewClass.init()
        view.zz_setupSubViews(views, styles: [.insetsModel(insets: .init(all: .zero))] + styles)
        return view
    }
}
