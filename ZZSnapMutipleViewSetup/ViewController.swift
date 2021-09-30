//
//  ViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {
    class Label: UILabel {
        var zz_width = 0
        var zz_height = 0
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            textColor = .black
            font = .systemFont(ofSize: 15)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
         
            return
            let realWidth = Int(self.bounds.width)
            let realHeight = Int(self.bounds.height)
            
            if tag == 1 || (realWidth == zz_width && realHeight == zz_height) {
                return
            }
            
            tag = 1
            var text = self.text ?? ""
            text += "偏\(Int(self.bounds.width) - zz_width)x\(Int(self.bounds.height) - zz_height)"
            self.text = text
        }
    }
    
    func getTitleLabel(_ text: String) -> Label {
        let label = Label()
        label.text = text
        return label
    }
    
    func getLabels(count: Int) -> [UILabel] {
        let labels = (0..<count).compactMap {
            index -> UILabel in
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "UILabel\(index)"
            label.textColor = .white
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 15)
            label.backgroundColor = .randomColor
            return label
        }
        
        return labels
    }
    
    
    func getOneRandomSizeView(
        maxWidth: CGFloat = kScreenWidth * 0.24,
        minWidth: CGFloat = kScreenWidth * 0.12,
        maxHeight: CGFloat = kScreenWidth * 0.12,
        minHeight: CGFloat = kScreenWidth * 0.06
    ) -> UIView {
        let view = UIView()
        
        let width = Int(arc4random() % UInt32(maxWidth - minWidth)) + Int(minWidth)
        let height = Int(arc4random() % UInt32(maxHeight - minHeight)) + Int(minHeight)
        
        let label = getTitleLabel("\(width)x\(height)")
        label.zz_width = width
        label.zz_height = height
        label.backgroundColor = .randomColor
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.size.equalTo(CGSize.init(width: width, height: height)).priority(.high)
        }
        return view
    }
    
    func getRandomSizeViews(
        count: Int,
        maxWidth: CGFloat = kScreenWidth * 0.24,
        minWidth: CGFloat = kScreenWidth * 0.12,
        maxHeight: CGFloat = kScreenWidth * 0.12,
        minHeight: CGFloat = kScreenWidth * 0.06
    ) -> [UIView] {
        let views = (0..<count).compactMap {
            index -> UIView in
            return getOneRandomSizeView(maxWidth: maxWidth, minWidth: minWidth, maxHeight: maxHeight, minHeight: minHeight)
        }
        return views
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return scrollView
    }()
    
    let view0 = RandomColorView()
    let view1 = RandomColorView()
    let view2 = RandomColorView()
    let view3 = RandomColorView()
    let view4 = RandomColorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    
}

