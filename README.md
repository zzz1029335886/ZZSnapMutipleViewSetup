# ZZSnapMutipleViewSetup
Use snapKit setup mutiple views on one line

One line layout subviews by Snapkit

enum Style {
        enum LayoutType {
            case horizontal
            case vertical
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

example: 
  
  view.zz_setupSubViews(getLabels(count: 10), .showType(.equalSize(3, 30)), .horizontalSpace(8), .verticalSpace(8), .insetsModel(insets: .init(all: 10)))
  
  view0.zz_setupSubViews(
            views0,
            .showType(.vertical),
            .alignment(.left(10)),
            .verticalSpace(5)
        )
        
  view1.zz_setupSubViews(
      getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
      .showType(.vertical),
      .alignment(.center())
  )
        
  view2.zz_setupSubViews(
      getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
      .showType(.vertical),
      .alignment(.right(10))
  )
  
  view0.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
            .showType(.horizontal),
            .alignment(.bottom(10)),
            .height(100)
        )
        
  view1.zz_setupSubViews(
      getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
      .showType(.horizontal),
      .alignment(.center()),
      .height(100)
  )

  view2.zz_setupSubViews(
      getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
      .showType(.horizontal),
      .alignment(.top(20)),
      .height(100)
  )
  
  view0.zz_setupSubViews(
            [
                getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20),
                .zz_flexView,
                getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20)
            ],
            .showType(.vertical),
            .alignment(.left(10)),
            .alignment(.right(10)),
            .height(200)
        )
        
  view1.zz_setupSubViews(
      [
          getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20),
          .zz_flexView,
          getOneRandomSizeView(maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 50, minHeight: 20)
      ],
      .showType(.horizontal),
      .alignment(.top(10)),
      .alignment(.bottom(10)),
      .height(100)
  )
    
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2003.48.26.png" width="390" height="844" />

<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2003.51.36.png" width="390" height="844" />

<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2003.52.17.png" width="390" height="844" />

<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2003.52.34.png" width="390" height="844" />

