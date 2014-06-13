//
//  TXViewController.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-10.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXViewController.h"

@interface TXViewController ()

@property (nonatomic , strong) UIView *leftView;
@property (nonatomic) NSUInteger currentIndex;

@end

@implementation TXViewController
{
    UIScrollView *_scroll;
//    UIView *_leftView;
    NSMutableArray *_viewList;
    CGSize _screenSize;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _viewList = [[NSMutableArray alloc]init];

    _screenSize = [UIScreen mainScreen].bounds.size;
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _screenSize.width, _screenSize.height)];
    _scroll.contentSize = CGSizeMake(_screenSize.width * 3, _screenSize.height);
    _scroll.backgroundColor = [UIColor blackColor];
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.delegate = self;
    
    
    [self.view addSubview:_scroll];
    
    UIViewController *controller1 = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalCenter"];
    UIView *view1 = controller1.view;
    view1.frame = CGRectMake(0, 0, _screenSize.width, _screenSize.height);
    view1.layer.cornerRadius = 8;
    [self setAnchorPoint:CGPointMake(0.8f, 0.5f) forView:view1];
    [_viewList addObject:view1];
    [_scroll addSubview:view1];
    
    UIViewController *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainJokeTable"];
    UIView *view2 = controller2.view;
    view2.frame = CGRectMake(_screenSize.width, 0, _screenSize.width, _screenSize.height);
    view2.layer.cornerRadius = 8;
    [self setAnchorPoint:CGPointMake(0.8f, 0.5f) forView:view2];
    [self addChildViewController:controller2];
    [_viewList addObject:view2];
    [_scroll addSubview:view2];
    
    UIViewController *controller3 = [self.storyboard instantiateViewControllerWithIdentifier:@"MakeJoke"];
    UIView *view3 = controller3.view;
    view3.frame = CGRectMake(_screenSize.width * 2, 0, _screenSize.width, _screenSize.height);
    view3.layer.cornerRadius = 8;
    [self setAnchorPoint:CGPointMake(0.8f, 0.5f) forView:view3];
    [_viewList addObject:view3];
    [_scroll addSubview:view3];
    

    _scroll.contentOffset = CGPointMake( _screenSize.width, _scroll.contentOffset.y);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    [self.view addGestureRecognizer:tap];

    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    
//    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        view.frame = CGRectMake(200, 200, 200, 200) ;
//    } completion:^(BOOL finished) {
//        
//    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapHandle:(UITapGestureRecognizer *)tap
{
    
}

//更改中心点
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}
//还原中心点
- (void)setDefaultAnchorPointforView:(UIView *)view
{
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:view];
}

- (NSUInteger)currentIndex
{
    CGFloat offset = _scroll.contentOffset.x;
    NSInteger index = offset/_screenSize.width;
    
    return index;
}

- (UIView *)leftView
{
    CGFloat offset = _scroll.contentOffset.x;
    NSUInteger index = self.currentIndex;
    UIView *view;
    //向右滑动
    if (offset < index * _screenSize.width)
    {
        if (index > 0)
        {
            view = _viewList[index - 1];
        }
        
    }else//向左滑动
    {
        view = [_viewList objectAtIndex:index];
        
    }
    
    return view;
}


#pragma mark - ScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translation = scrollView.contentOffset;
    
    CGFloat oldDistance = self.currentIndex * _screenSize.width;
    CGFloat distance = (translation.x - oldDistance)/2;
    
    UIView *leftView = self.leftView;

    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/180 * -distance, 0, 1, 0);
    CATransform3D transloate = CATransform3DMakeTranslation(0, 0, -distance);
    CATransform3D mat = CATransform3DConcat(rotate, transloate);
    leftView.layer.transform = CATransform3DPerspect(mat, CGPointZero, 500);
    
    

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
#pragma mark - 变换方法
//将一个正交变换转换成一个透视变换
CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));

}

//获取一个透视3D变换
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}
@end
