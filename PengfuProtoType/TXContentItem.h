//
//  TXContentItem.h
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-17.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ContentDataType)
{
    TX_CONTENT_JOKE = 1,
    TX_CONTENT_PICTURE
};

@interface TXContentItem : NSObject
@property (nonatomic, strong) id item;
@property (nonatomic) ContentDataType type;
@end
