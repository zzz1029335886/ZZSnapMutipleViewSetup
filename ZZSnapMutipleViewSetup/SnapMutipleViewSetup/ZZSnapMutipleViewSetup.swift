//
//  ZZSnapMutipleViewSetup.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

struct ZZSnapMutipleViewSetup {
    struct Insets {
        static let zero: Insets = .init(top: 0, left: 0, bottom: 0, right: 0)
        
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
        
        init(horizontal: CGFloat?, vertical: CGFloat?) {
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
            /// 水平
            case horizontal
            /// 垂直
            case vertical
            /// 宽度相同
            case equalSize(
                _ countInLine: Int = 1,
                _ itemHeight: CGFloat? = nil,
                _ lastBottomPriority: ConstraintPriority = .required
            )
        }
        
        /// 对齐方式
        enum Alignment {
            case left(_ padding: CGFloat = 0)
            case right(_ padding: CGFloat = 0)
            case top(_ padding: CGFloat = 0)
            case bottom(_ padding: CGFloat = 0)
            case center(_ padding: CGFloat = 0)
        }
        
        case showType(_ type: LayoutType)
        case horizontalSpace(_ space: CGFloat? = 0)
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
        var insets: ZZSnapMutipleViewSetup.Insets?
        var zz_contentView: UIView?
    }
    class SpaceView: UIView, ZZSnapMutipleViewSetupSpace {
        var insets: ZZSnapMutipleViewSetup.Insets?
        var zz_contentView: UIView?
        var zz_width: CGFloat?
        var zz_height: CGFloat?
    }
    class AlignmentView: UIView, ZZSnapMutipleViewSetupAlignment {
        var zz_contentView: UIView?
        var insets: ZZSnapMutipleViewSetup.Insets?
        var alignments: [ZZSnapMutipleViewSetup.Style.Alignment] = []
    }
}

protocol ZZSnapMutipleViewSetupContain: UIView {
    var zz_contentView: UIView? {set get}
    var insets: ZZSnapMutipleViewSetup.Insets? {set get}
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
            make.edges.equalTo(insets?.edgeInsets ?? .zero)
        }
    }
}

protocol ZZSnapMutipleViewSetupSpace: ZZSnapMutipleViewSetupContain {
    var zz_width: CGFloat? {set get}
    var zz_height: CGFloat? {set get}
}

extension ZZSnapMutipleViewSetupSpace{
    func setup() {
        setupContain()
        
    }
}
protocol ZZSnapMutipleViewSetupFlex: ZZSnapMutipleViewSetupContain {}
protocol ZZSnapMutipleViewSetupAlignment: ZZSnapMutipleViewSetupContain {
    var alignments: [ZZSnapMutipleViewSetup.Style.Alignment]{ set get }
}

extension UIColor{
    class var randomColor: UIColor{
        get{
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

private struct AssociatedKeys {
    static var kZZSnapMutipleViewSetupWidget = "kZZSnapMutipleViewSetupWidget"
}

extension UIView{
    var zz_widget: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kZZSnapMutipleViewSetupWidget) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kZZSnapMutipleViewSetupWidget, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension UIView{
    
    func zz_widget(_ widget: CGFloat) -> Self {
        self.zz_widget = widget
        return self
    }
    
    static var zz_flexView: ZZSnapMutipleViewSetup.FlexView{
        return ZZSnapMutipleViewSetup.FlexView()
    }
    
    func zz_flexView(insets: ZZSnapMutipleViewSetup.Insets? = nil) -> ZZSnapMutipleViewSetup.FlexView{
        return UIView.zz_flexView(self, insets: insets)
    }
    
    static func zz_flexView(_ view: UIView, insets: ZZSnapMutipleViewSetup.Insets? = nil) -> ZZSnapMutipleViewSetup.FlexView{
        let flexView = zz_flexView
        flexView.zz_contentView = view
        flexView.insets = insets
        return flexView
    }
    
    static func zz_alignmentView(_ view: UIView, insets: ZZSnapMutipleViewSetup.Insets? = nil, alignments: ZZSnapMutipleViewSetup.Style.Alignment...) -> ZZSnapMutipleViewSetup.AlignmentView {
        let alignmentView = ZZSnapMutipleViewSetup.AlignmentView()
        alignmentView.alignments = alignments
        alignmentView.zz_contentView = view
        alignmentView.insets = insets
        return alignmentView
    }
    
    static func zz_spaceView(_ view: UIView, insets: ZZSnapMutipleViewSetup.Insets? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> ZZSnapMutipleViewSetup.SpaceView {
        let spaceView = ZZSnapMutipleViewSetup.SpaceView()
        spaceView.zz_width = width
        spaceView.zz_height = height
        spaceView.zz_contentView = view
        spaceView.insets = insets
        
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
        view.zz_setupSubViews(views, styles: styles + [.insetsModel(insets: .init(all: .zero))])
        return view
    }
}
