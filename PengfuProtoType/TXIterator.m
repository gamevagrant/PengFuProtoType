//
//  TXContentData.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-13.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXIterator.h"


@implementation TXIterator
{
    NSArray *_list;
    NSMutableDictionary *_itemTypeDic;
    NSUInteger _num;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _num = 0;
    }
    return self;
}

- (id)initWithArray:(NSArray *)array
{
    self = [self init];
    if (self)
    {
        _list = array;
    }
    return self;
}


- (id)first
{
    _num = 0;
    return [_list objectAtIndex:_num];
}

- (id)next
{
    if (_num < _list.count) {
        id item = [_list objectAtIndex:_num];
        _num++;
        return item;
    }
    return nil;
}

- (id)currentItem
{
    return [_list objectAtIndex:_num];
}

- (BOOL)hasNext
{
    if (_num >= _list.count || _list[_num] == NULL)
    {
        return NO;
    }else
    {
        return YES;
    }
}
@end
