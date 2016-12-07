//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/12/7.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGradientLayer];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addGradientLayer
{
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = (CGRect){CGPointZero,CGSizeMake(200, 200)};
    colorLayer.position = self.view.center;
    [self.view.layer addSublayer:colorLayer];
    
    //颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.0/255 green:222.0/255 blue:255.0/255 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:75.0/255 green:255.0/255 blue:249.0/255 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:190.0/255 green:253.0/255 blue:255.0/255 alpha:1.0].CGColor];
    
    colorLayer.startPoint = CGPointMake(0.0, 0.0);//起始点
    colorLayer.endPoint = CGPointMake(1.0, 1.0);//结束点
    colorLayer.locations = @[@(0.25),@(0.5),@(0.75)];//颜色渐变位置分割线
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
