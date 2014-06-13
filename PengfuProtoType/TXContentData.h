//
//  TXContentData.h
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-13.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ContentDataType)
{
    TX_CONTENT_JOKE = 1,
    TX_CONTENT_PICTURE
};

@protocol Iterator <NSObject>

@required
- (id)first;
- (id)next;
- (BOOL)isDone;
- (id)currentItem;

@end

@interface TXContentData : NSObject <Iterator>

@property (nonatomic) ContentDataType currentItemType;

- (void)addItem:(id)item type:(ContentDataType)type;

@end
