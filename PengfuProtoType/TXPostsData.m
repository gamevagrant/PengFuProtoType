//
//  TXPostsData.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-13.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXPostsData.h"
#import "TXIterator.h"

@implementation TXPostsData
- (void)addContentList:(NSArray *)list
{
    self.contentIterator = [[TXIterator alloc]initWithArray:list];
}
@end
