//
//  TXMainListTableViewCellHeader.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-20.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewCellHeader.h"
#import "TXImageView.h"
#import "TXDefine.h"

@implementation TXMainListTableViewCellHeader
{
    TXImageView *_imageView;
    UILabel *_label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    _imageView = [[TXImageView alloc]initWithFrame:CGRectMake(20 , 2, 30 , 30)];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, 2, 200, 30)];
 
    [self addSubview:_imageView];
    [self addSubview:_label];
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

- (void)setData:(TXPostsData *)data
{
    NSURL *url = [NSURL URLWithString:data.avatar];
    TXImage *image = [[TXImage alloc]initWithURL:url];
    _imageView.image = image;
    _label.text = data.name;
    
}
@end
