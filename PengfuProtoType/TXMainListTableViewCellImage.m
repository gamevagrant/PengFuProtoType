//
//  TXMainListTableViewCellImage.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-20.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewCellImage.h"
#import "TXImageView.h"
#import "TXDefine.h"

@implementation TXMainListTableViewCellImage
{
    TXImageView *_imageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTxImage:(TXImage *)txImage
{
    CGFloat width = self.frame.size.width - Margins * 2;
    CGFloat height = width/txImage.size.width * txImage.size.height;
    
    if (!_imageView) {
        _imageView = [[TXImageView alloc] init];
    }
    _imageView.frame = CGRectMake(Margins, Margins, width, height);
    _imageView.image = txImage;

    [self addSubview:_imageView];
}

@end
