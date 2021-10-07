####showType：显示类型
1. equalSize(3, 30, .required)：每个子view的大小相同
3：每行个数
30：每个view的高度
required：自动撑开view的高度
2. vertical：垂直布局
3. horizontal：水平布局

####space/horizontalSpace&verticalSpace：间距/水平间距&垂直间距，[最后一个值有效]
0. space：间距
1. horizontalSpace：水平间距，showType为vertical无效
2. verticalSpace：垂直间距，showType为horizontal无效

####insets/insetsModel：内间距，[只需设置一次，最后一个值有效]

####alignment&alignments：对齐方式，[可传值]
1. left：左对齐
2. right：右对齐
3. top：上对齐
4. bottom：下对齐
5. center：中对齐
6. insets：上下左右对齐

####height：自身的高度
####width：自身的宽度

> equalSize
```
        view0.zz_setupSubViews(
            getLabels(count: 10),
            .showType(.equalSize(3, 30, .high)),
            .horizontalSpace(8),
            .verticalSpace(8),
            .insetsModel(insets: .init(all: 10))
        )
```
![image.png](https://upload-images.jianshu.io/upload_images/20553471-6aba038e38174ddf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> vertical
```
        view1.zz_setupSubViews(
            getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
            .showType(.vertical),
            .alignment(.center(0))
        )
```
![image.png](https://upload-images.jianshu.io/upload_images/20553471-28986d6ad7d256c5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
        view2.zz_setupSubViews(
            getRandomSizeViews(count: 5, maxWidth: kScreenWidth * 0.5, minWidth: kScreenWidth * 0.25, maxHeight: 50, minHeight: 20),
            .showType(.vertical),
            .alignment(.right(10))
        )
```
![image.png](https://upload-images.jianshu.io/upload_images/20553471-d75ab2538a73b259.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> horizontal
```
        view1.zz_setupSubViews(
            getRandomSizeViews(count: 3, maxWidth: kScreenWidth * 0.25, minWidth: kScreenWidth * 0.125, maxHeight: 70, minHeight: 30),
            .showType(.horizontal),
            .alignment(.center()),
            .horizontalSpace(8),
            .height(100)
        )
```
![image.png](https://upload-images.jianshu.io/upload_images/20553471-6f33f39a35b3981d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)




