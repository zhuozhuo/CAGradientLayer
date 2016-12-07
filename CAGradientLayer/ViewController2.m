//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/12/7.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ViewController2.h"

// 将常数转换为度数
#define   DEGREES(degrees)  ((M_PI * (degrees))/ 180.f)

@interface ViewController2 (){
    
}
@property (nonatomic, strong) NSTimer  *timer1;
@property (nonatomic, strong) NSTimer  *timer2;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addCircleGradientLayer];
    [self addRectangleGradientLayer];
    // Do any additional setup after loading the view.
}


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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
