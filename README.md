#AGradientLayer实现背景颜色渐变效果,和某些特效。

##  先看效果动画

![渐变背景颜色](http://upload-images.jianshu.io/upload_images/2926059-34dfc7afdf45334d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![特效1](http://upload-images.jianshu.io/upload_images/2926059-4de31158aaec43ec.gif?imageMogr2/auto-orient/strip)


![特效2](http://upload-images.jianshu.io/upload_images/2926059-4ca4ff9da6848dcf.gif?imageMogr2/auto-orient/strip)

### 渐变背景颜色

```objective-c
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = (CGRect){CGPointZero,CGSizeMake(200, 200)};
    colorLayer.position = self.view.center;
    [self.view.layer addSublayer:colorLayer];
    
    //颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.0/255 green:222.0/255 blue:255.0/255 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:75.0/255 green:255.0/255 blue:249.0/255 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:190.0/255 green:253.0/255 blue:255.0/255 alpha:1.0].CGColor];
    
    colorLayer.startPoint = CGPointMake(0.0, 0.0);//起始点
    colorLayer.endPoint = CGPointMake(1.0, 1.0);//结束点
    colorLayer.locations = @[@(0.25),@(0.5),@(0.75)];//颜色渐变位置分割线
```

> 这里得注意`startPoint`,`endPoint`,`locations`遵循`Layler`的坐标系，范围为(0,1),`locations`里面的值是递增的，位置点可以看做是y值为0在x轴上的点。至于每个颜色所暂用区域和渐变到下一个颜色的分割线是由`locations`上的点到`startPoint`,`endPoint`这条直线所确定确定。

![蓝线为起始位置和结束位置，黄线为分割线](http://upload-images.jianshu.io/upload_images/2926059-bb0031d34bf7a261.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 特效1

```objective-c
-(void)addGradientLayer
{
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = (CGRect){CGPointZero,CGSizeMake(200, 200)};
    colorLayer.position = self.view.center;
    [self.view.layer addSublayer:colorLayer];
    
    //颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    colorLayer.locations = @[@(0.25),@(0.5),@(0.75)];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(1, 0);
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer *timer){
        static CGFloat length = -0.1f;
        if (length >= 1.1) {
            length = - 0.1f;
            [CATransaction setDisableActions:YES];
            colorLayer.locations = @[@(length),@(length + 0.1),@(length + 0.15)];
        }else{
           [CATransaction setDisableActions:NO];
          colorLayer.locations = colorLayer.locations = @[@(length),@(length + 0.1),@(length + 0.15)];            
        }
        length += 0.1f;
    }];
    [_timer fire];
   
    
}

```

> 这里只是做了个定时器对位置对`locations`进行定增操作。

#特效2

```objective-c
-(void)addCircleGradientLayer
{
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
    colorLayer.frame = CGRectMake(0, 120, 200, 200);
    colorLayer.position = CGPointMake(self.view.center.x, colorLayer.frame.origin.y);
    [self.view.layer addSublayer:colorLayer];
    
    // 颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor whiteColor].CGColor,
                          (__bridge id)[UIColor redColor].CGColor];
    colorLayer.locations  = @[@(-0.2), @(-0.1), @(0)];
    
    // 起始点
    colorLayer.startPoint = CGPointMake(0, 0);
    
    // 结束点
    colorLayer.endPoint   = CGPointMake(1, 0);
    
    CAShapeLayer *circle = [self createCircleWithCenter:CGPointMake(100, 110) radius:90 startAngle:DEGREES(0) endAngle:DEGREES(360) clockwise:YES lineDashPattern:nil];
    circle.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:circle];

    circle.strokeEnd = 1.0f;
    colorLayer.mask = circle;
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer){
        static NSInteger index = 1;
        if (index ++ % 2 == 0) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
            animation.fromValue = @[@(-0.1), @(-0.15), @(0)];
            animation.toValue   = @[@(1.0), @(1.1), @(1.15)];
            animation.duration  = 1.0;
            [colorLayer addAnimation:animation forKey:nil];
        }
        
    }];
    [_timer1 fire];
}

-(CAShapeLayer *)createCircleWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise lineDashPattern:(NSArray *)lineDashPattern
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineCap = kCALineCapRound;
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:clockwise];
    // 获取path
    layer.path = path.CGPath;
    layer.position = center;
    // 设置填充颜色为透明
    layer.fillColor = [UIColor clearColor].CGColor;
    // 获取曲线分段的方式
    if (lineDashPattern)
    {
        layer.lineDashPattern = lineDashPattern;
    }
    
    return layer;
    
}


-(void)addRectangleGradientLayer
{
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
    colorLayer.frame = CGRectMake(0, 300, 300, 100);
    colorLayer.position = CGPointMake(self.view.center.x, colorLayer.frame.origin.y);
    [self.view.layer addSublayer:colorLayer];
    
    // 颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor whiteColor].CGColor,
                          (__bridge id)[UIColor redColor].CGColor];
    colorLayer.locations  = @[@(-0.2), @(-0.1), @(0)];
    
    // 起始点
    colorLayer.startPoint = CGPointMake(0, 0);
    
    // 结束点
    colorLayer.endPoint   = CGPointMake(1, 0);
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer){
        static NSInteger index = 1;
        if (index ++ % 2 == 0) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
            animation.fromValue = @[@(-0.1), @(-0.15), @(0)];
            animation.toValue   = @[@(1.0), @(1.1), @(1.15)];
            animation.duration  = 1.0;
            [colorLayer addAnimation:animation forKey:nil];
        }
        
    }];
    [_timer2 fire];
}
```

> 这里其实是两个特效，只是很类似所以放在了一起。第一个是加了一个圆形的遮罩然后对`locations`进行动画操作。第二个只是简单的对`locations`进行动画操作。

### 扩展
其实`CAGradientLayer 的这四个属性 `colors`,` locations`, `startPoint`, `endPoint` 我们都是可以进行动画操作.
