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
