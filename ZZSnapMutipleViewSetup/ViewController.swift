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
    var selectedView: RandomColorView?
    
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
    ) -> RandomColorView {
        let view = RandomColorView()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
        
        let w = maxWidth - minWidth
        let h = maxHeight - minHeight
        
        let width = w == 0 ? Int(maxWidth) : Int(arc4random() % UInt32(w)) + Int(minWidth)
        let height = h == 0 ? Int(maxHeight) : Int(arc4random() % UInt32(h)) + Int(minHeight)
        
        let label = getTitleLabel("\(width)x\(height)")
        label.zz_width = width
        label.zz_height = height
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
            index -> RandomColorView in
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
    
    lazy var view0: RandomColorView = {
        let view = RandomColorView()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
        return view
    }()
    lazy var view1: RandomColorView = {
        let view = RandomColorView()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
        return view
    }()
    lazy var view2: RandomColorView = {
        let view = RandomColorView()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
        return view
    }()
    lazy var view3: RandomColorView = {
        let view = RandomColorView()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
        return view
    }()
    lazy var view4: RandomColorView = {
        let view = RandomColorView()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem.init(title: "Plus", style: .done, target: self, action: #selector(plus)),
            UIBarButtonItem.init(title: "Reduce", style: .done, target: self, action: #selector(reduce))
        ]
    }
    
    var padding: CGFloat = 0
    
    @objc
    func plus() {
        
    }
    
    @objc
    func reduce() {
        
    }
    
    @objc
    func clickView(_ ges: UIGestureRecognizer) {
        guard let view = ges.view as? RandomColorView else { return }
        self.selectedView?.isSelected = false
        self.selectedView = view
        view.isSelected = true
    }
    
}

