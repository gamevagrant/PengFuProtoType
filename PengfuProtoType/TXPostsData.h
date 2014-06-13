//
//  TXPostsData.h
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-13.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TXContentData;
@protocol Iterator;


@interface TXPostsData : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic) NSUInteger numTop;
@property (nonatomic) NSUInteger numTread;
@property (nonatomic,strong) NSDate *date;

@property (nonatomic,strong) TXContentData *content;//帖子内容
@property (nonatomic,strong) id<Iterator> commentList;//评论列表
@end
