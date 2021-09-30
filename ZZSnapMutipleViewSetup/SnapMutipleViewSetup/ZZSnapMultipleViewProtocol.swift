//
//  ZZSnapMultipleViewProtocol.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

/// 批量设置时空白占位view
protocol UISnapSpaceProtocol: UIView {
    var spaceHeight: CGFloat? {set get}
    var spaceWidth: CGFloat? {set get}
    var topMargin: CGFloat? {set get}
    var bottomMargin: CGFloat? {set get}
    var tralingMargin: CGFloat? {set get}
    var leadingMargin: CGFloat? {set get}
    
    /// 设置宽高
    /// - Parameters:
    ///   - height: 高度
    ///   - width: 宽度
    func space(
        height: CGFloat?,
        width: CGFloat?,
        top: CGFloat?,
        bottom: CGFloat?,
        leading: CGFloat?,
        traling: CGFloat?
    )
}

extension UISnapSpaceProtocol{
    func space(
        height: CGFloat?,
        width: CGFloat?,
        top: CGFloat?,
        bottom: CGFloat?,
        leading: CGFloat?,
        traling: CGFloat?
    ) {
        self.spaceWidth = width
        self.spaceHeight = height
        self.topMargin = top
        self.bottomMargin = bottom
        self.leadingMargin = leading
        self.tralingMargin = traling
    }
}

extension UISnapSpaceProtocol{
    /// 设置约束
    func setSnap(){
        if self.superview == nil {
            fatalError("superview is nil")
        }
        
        if let width = spaceWidth {
            if width == UISnapSpaceView.automatic {
                self.snp.makeConstraints { (m) in
                    m.width.equalToSuperview().priority(.medium)
                }
            } else {
                self.snp.makeConstraints { (m) in
                    m.width.equalTo(width).priorityMedium()
                }
            }
        }
        
        if let height = spaceHeight {
            if height == UISnapSpaceView.automatic {
                self.snp.makeConstraints { (m) in
                    m.height.equalToSuperview().priority(.medium)
                }
            } else {
                self.snp.makeConstraints { (m) in
                    m.height.equalTo(height).priorityMedium()
                }
            }
        }
        
        if let top = topMargin {
            snp.makeConstraints { (m) in
                m.top.equalTo(top)
            }
        }
        
        if let leading = leadingMargin {
            snp.makeConstraints { (m) in
                m.leading.equalTo(leading)
            }
        }
        
        if let traling = tralingMargin {
            snp.makeConstraints { (m) in
                m.trailing.equalTo(traling)
            }
        }
        
        if let bottom = bottomMargin {
            snp.makeConstraints { (m) in
                m.bottom.equalTo(bottom)
            }
        }
    }
}

/// 对齐方式
enum UISnapContainerAlignment {
    case left(_ padding: CGFloat = 0)
    case right(_ padding: CGFloat = 0)
    case top(_ padding: CGFloat = 0)
    case bottom(_ padding: CGFloat = 0)
    case center
}

protocol UISnapContainerProtocol: UIView {
    /// 对齐方式
    /// 垂直布局时，左中右可用
    /// 水平布局时，上中下可用
    var alignment: UISnapContainerAlignment{ set get }
    var alignments: [UISnapContainerAlignment]{ set get }
}

/// 伸缩
protocol UISnapFlexProtocol: UIView {
    
}

/// 空间
class UISnapSpaceView: UIView, UISnapSpaceProtocol {
    static let automatic: CGFloat = -1
    
    var topMargin: CGFloat?
    var bottomMargin: CGFloat?
    var tralingMargin: CGFloat?
    var leadingMargin: CGFloat?
    
    var spaceHeight: CGFloat?
    var spaceWidth: CGFloat?
    
    init(
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        top: CGFloat? = nil,
        bottom: CGFloat? = nil,
        leading: CGFloat? = nil,
        traling: CGFloat? = nil
    ) {
        super.init(frame: .zero)
        
        space(height: height, width: width, top: top, bottom: bottom, leading: leading, traling: traling)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 批量设置容器
class UISnapContainerView: UIView, UISnapContainerProtocol, UISnapSpaceProtocol {
    var alignments: [UISnapContainerAlignment] = []
    var topMargin: CGFloat?
    var bottomMargin: CGFloat?
    var tralingMargin: CGFloat?
    var leadingMargin: CGFloat?
    
    var alignment: UISnapContainerAlignment = .center
    var spaceHeight: CGFloat?
    var spaceWidth: CGFloat?
    
    init(_ contentView: UIView? = nil,
         height: CGFloat? = nil,
         width: CGFloat? = nil,
         top: CGFloat? = nil,
         bottom: CGFloat? = nil,
         leading: CGFloat? = nil,
         traling: CGFloat? = nil,
         alignment: UISnapContainerAlignment = .center,
         alignments: [UISnapContainerAlignment] = []
    ) {
        super.init(frame: .zero)
        
        self.space(
            height: height,
            width: width,
            top: top,
            bottom: bottom,
            leading: leading,
            traling: traling
        )
        
        self.alignment = alignment
        self.alignments = alignments
        
        if let contentView = contentView {
            addSubview(contentView)
            contentView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UISnapFlexView: UIView, UISnapFlexProtocol {
    
}
