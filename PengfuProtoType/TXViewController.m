//
//  TXViewController.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-10.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXViewController.h"

@interface TXViewController ()

@end

@implementation TXViewController
{
    UIScrollView *_scroll;
    UIView *_leftView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1000, 940)];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [self.view addSubview:_leftView];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    image.image = [UIImage imageNamed:@"Image"];
    [_leftView addSubview:image];
    

    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerHandle:)];
    [_leftView addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panGestureRecognizerHandle:(UIPanGestureRecognizer *) gestureRecognizer
{
    
    
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    
    NSLog(@"%f/%f",translation.x,translation.y);
//    CATransform3D rotate = CATransform3DMakeRotation(M_PI/180 * 30, 0, 1, 0);
//    _leftView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 1000);
    
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];//  注意一旦你完成上述的移动，将translation重置为0十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！

    
    
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
@end
