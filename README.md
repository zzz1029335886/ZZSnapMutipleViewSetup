# ZZSnapMutipleViewSetup
Use snapKit setup mutiple views on one line

One line layout subviews by Snapkit

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