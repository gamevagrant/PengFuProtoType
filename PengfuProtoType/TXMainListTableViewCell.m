//
//  TXMainListTableViewCell.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-12.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewCell.h"
#import "TXIterator.h"
#import "TXContentItem.h"
#import "TXImage.h"
#import "TXImageView.h"



@implementation TXMainListTableViewCell
{
    NSMutableDictionary *_uiContentList;
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

- (void)setCellData:(TXPostsData *)data
{
    CGFloat width = self.frame.size.width - Margins * 2;
    TXIterator *iterator = data.contentIterator;
    _uiContentList = [[NSMutableDictionary alloc]init];
    
    CGFloat offsetY = HeadHeight;
    while (iterator.hasNext)
    {
        TXContentItem *content = [iterator next];
        if (content.type == TX_CONTENT_PICTURE)
        {
            TXImage *txImage = content.item;
            CGFloat height = width/txImage.size.width * txImage.size.height;
            
            
            TXImageView *imageView = [[TXImageView alloc]initWithFrame:CGRectMake(Margins, offsetY, width, height)];
            imageView.image = txImage;
            [_uiContentList setObject:imageView forKey:txImage.url];
            [self addSubview:imageView];
            offsetY += height + 10;
            
        }else
        {
            NSString *str = content.item;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Margins, offsetY, width, 0)];
            label.numberOfLines = 0;
            label.text = str;
            [label sizeToFit];
            offsetY += label.frame.size.height;
            [_uiContentList setObject:label forKey:str];
            [self addSubview:label];
        }
        offsetY += Margins;
    }
    [iterator first];

//    CGFloat offsetY = HeadHeight;
//    while (iterator.hasNext)
//    {
//        TXContentItem *content = [iterator next];
//        if (content.type == TX_CONTENT_PICTURE)
//        {
//            TXImage *txImage = content.item;
//            CGFloat height = width/txImage.size.width * txImage.size.height;
//            
//            
//            TXImageView *imageView = [[TXImageView alloc]initWithFrame:CGRectMake(Margins, offsetY, width, height)];
//            imageView.image = txImage;
//            [_uiContentList setObject:imageView forKey:txImage.url];
//            [self addSubview:imageView];
//            offsetY += height + 10;
//
//        }else
//        {
//            NSString *str = content.item;
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Margins, offsetY, width, 0)];
//            label.numberOfLines = 0;
//            label.text = str;
//            [label sizeToFit];
//            offsetY += label.frame.size.height;
//            [_uiContentList setObject:label forKey:str];
//            [self addSubview:label];
//        }
//        offsetY += Margins;
//    }
//    [iterator first];
    
}

- (void)prepareForReuse
{
    for (UIView *view in _uiContentList.allValues) {
        [view removeFromSuperview];
    }
    _uiContentList = nil;
}
@end
