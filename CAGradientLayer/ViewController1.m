//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/12/7.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 (){

}
@property (nonatomic, strong) NSTimer  *timer;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGradientLayer];
    // Do any additional setup after loading the view.
}


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
