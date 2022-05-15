# learns_ios_Core_Graphics

## 基本概念

+ 绘制操作是一页一页绘制上去，之前的不可修改，可以覆盖，所以顺序很重要。
+ 图形上下文：绘图目标，比如屏幕、PDF、图片、位图。
+ 不透明属性：各种绘图的方式，图像、Path、图层、油漆、Layer。
+ 图形状态：绘图的一些属性，比如填充颜色。
+ CG的坐标系反的，但UIKit返回的矫正之后的。
+ CG的对象创建后需要销毁。

### 颜色空间

+ 全局：Quartz 提供了一套用于设置填充颜色、描边颜色、颜色空间和 alpha 的函数。
+ 颜色空间错了会改变图像的颜色。
+ 颜色值范围从0到1，代表强度，所以红色通道就是 123/255。
+ 不透明颜色值导致颜色混合。
+ 手机上灰色、护眼，本质上更改颜色空间。

### 变换

+ Quartz 2D 绘图模型定义了两个完全独立的坐标空间：代表文档页面的用户空间和代表设备原始分辨率的设备空间。
+ 用户空间坐标是与设备空间中像素分辨率无关的浮点数。
+ 当您想要打印或显示您的文档时，Quartz 将用户空间坐标映射到设备空间坐标。
+ CTM：current transformation matrix
+ 仿射变换：用一些列仿射变换函数创建一个矩阵，然后应用于CTM一次性成型。
+ 如果对背后的数学原理感兴趣：https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/dq_affine.html#//apple_ref/doc/uid/TP30001066-CH204-CJBECIAD

### 模式

+ 模式是重复绘制到图形上下文的一系列绘图操作。
+ 模式空间与用户空间是分开的。对模式空间进行变换不会应用到用户空间。
+ 平铺：用户空间向设备空间做的一个适配。
+ 图案分为：彩色图案 和 模板图案
+ 彩色图案：彩色图案中的颜色被指定为图案单元创建过程的一部分，而不是图案绘制过程的一部分。
+ 模板图案：图案仅根据其形状定义。
+ 因为空间是隔离开的，需要设置颜色空间。

### 阴影

+ 阴影具有三个特征：X偏移、Y偏移、边缘模糊值


### 渐变

+ Quartz 提供了两种用于创建渐变的不透明数据类型：CGShadingRef和CGGradientRef
+ 着色器功能之一。
+ 渐变可以创建一个阴影球体，甚至3D效果。
+ CGShading：提供一个颜色计算函数。
+ CGGradient：是 CGShading 对象的子集，在设计时考虑到了易用性，创建渐变对象时，您提供了一组位置和颜色。

### 透明层

+ 对一组绘制进行合成，比如阴影。

### 位图图像和图像蒙版

+ 位图图像（或采样图像）是像素（或样本）数组。每个像素代表图像中的一个点。
+ 图像蒙版是一个位图，它指定要绘制的区域，但不指定颜色。
+ CGImageCreate需要选择颜色的布局信息，是ARGB，还是RGBA。

### 核心图形图层绘制

+ 使用场景：重用高质量高消耗屏幕外的渲染、反复绘制、缓冲。
+ 核心：CGContextDrawLayerAtPoint（绘制） 和 CGContextTranslateCTM（移动绘制起点）

### PDF

+ 


## 参考文档

- [Quartz 2D Programming Guide]( https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_overview/dq_overview.html#//apple_ref/doc/uid/TP30001066-CH202-TPXREF101)
- [iOS Drawing Practical UIKit Solutions ](https://github.com/wangdicen/iOS-Drawing-Practical-UIKit-Soluations-Translation)
