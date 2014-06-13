//
//  TXMainListTableViewCell.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-12.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewCell.h"
#import "TXContentData.h"

@implementation TXMainListTableViewCell
{
    NSArray *list;
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

- (void)setCellData:(NSDictionary *)data
{
    list = [NSArray arrayWithObjects:@"http://img5.pengfu.cn/big/777/662777.jpg",@"http://img10.pengfu.cn/big/966/661966.jpg" ,nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"http://u5.mm-img.com/rs/res/mm2011/22/2011/11/21/a494/687/16687494/picture1240x3201841620505.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.avatar.image = image;
                self.nameLabel.text = @"蜡笔小新";
                NSURL* url2 = [NSURL URLWithString:@"http://www.youku.com"];//创建URL
                NSURLRequest* request = [NSURLRequest requestWithURL:url2];//创建NSURLRequest
                [self.contentWebView loadRequest:request];
            }
        });
    });
    
}
@end
