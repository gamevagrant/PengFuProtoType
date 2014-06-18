//
//  TXImageView.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-17.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXImageView.h"

@implementation TXImageView
{
    UIProgressView *_progress;
    UILabel *_tipLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _progress = [[UIProgressView alloc]init];
        [self addSubview:_progress];
        
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    return self;
}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)layoutSubviews
{
    CGSize size = self.frame.size;
    _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    _progress.frame = CGRectMake(size.width * 0.1, size.height/2, size.width * 0.8f, 10);
    _tipLabel.frame = CGRectMake(8, size.height/2-40, size.width - 16, 30);
}

- (void)setImage:(TXImage *)image
{
    if (image.image) {
        _tipLabel.hidden = YES;
        _progress.hidden = YES;
        _imageView.image = image.image;
    }else
    {
        _tipLabel.hidden = NO;
        _progress.hidden = NO;
        
        _tipLabel.text = @"正在加载，请稍后";
        [image loadImageWithCompletionHandler:^(UIImage *image, NSURL *url,NSError *error) {
            
            _tipLabel.hidden = YES;
            _progress.hidden = YES;
            _imageView.image = image;
            
        } progressHandle:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            
            _progress.progress = totalBytesWritten/(float)totalBytesExpectedToWrite;
        }];

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
