//
//  TXContentData.h
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-13.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol Iterator <NSObject>

@required
- (NSUInteger)count;
- (id)first;
- (id)next;
- (BOOL)hasNext;
- (id)currentItem;

@end

@interface TXIterator : NSObject <Iterator>

- (id)initWithArray:(NSArray *)array;
- (id)getItemWidthIndex:(NSInteger)index;

@end
