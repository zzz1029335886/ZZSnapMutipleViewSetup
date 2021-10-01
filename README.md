# ZZSnapMutipleViewSetup
Use snapKit setup mutiple views on one line

One line layout subviews by Snapkit

example: 
  
      view.zz_setupSubViews(
        [view0, view1],
        .showType(.vertical),
        .verticalSpace(30),
        .alignment(.center()),
        .alignment(.left(10)),
        .insets(top: 124, left: 30, bottom: nil, right: 30)
    )
    
    view0.zz_setupSubViews(
        getLabels(count: 10),
        .showType(.equalSize(3, 30)),
        .horizontalSpace(8),
        .verticalSpace(8),
        .insetsModel(insets: .init(all: 10))
    )
    
    view1.zz_setupSubViews(
        getLabels(count: 10),
        .showType(.equalSize(3, 30)),
        .horizontalSpace(8),
        .verticalSpace(8)
    )

<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.25.53.png" width=“390px">
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.26.04.png" width=“390px">
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.44.25.png" width=“390px">
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.44.42.png" width=“390px">
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.44.52.png" width=“390px">
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.44.24.png" width=“390px">
<img src="https://github.com/zzz1029335886/ZZSnapMutipleViewSetup/blob/master/ZZSnapMutipleViewSetup/Pictures/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-01%20at%2020.45.32.png" width=“390px">
