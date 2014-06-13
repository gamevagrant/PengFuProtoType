//
//  TXContentData.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-13.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXContentData.h"


@implementation TXContentData
{
    NSMutableArray *_list;
    NSMutableDictionary *_itemTypeDic;
    NSUInteger _num;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _list = [[NSMutableArray alloc]init];
        _num = 0;
    }
    return self;
}

- (ContentDataType)currentItemType
{
    return (ContentDataType)[_itemTypeDic objectForKey:[NSNumber numberWithUnsignedInteger:_num]];
}

- (void)addItem:(id)item type:(ContentDataType)type
{
    [_list addObject:item];
    [_itemTypeDic setObject:[NSNumber numberWithUnsignedInteger:type] forKey:[NSNumber numberWithUnsignedInteger:_list.count-1]];
}

- (id)first
{
    _num = 0;
    return [_list objectAtIndex:_num];
}

- (id)next
{
    _num++;
    return [_list objectAtIndex:_num];
}

- (id)currentItem
{
    return [_list objectAtIndex:_num];
}

- (BOOL)isDone
{
    if (_num < _list.count)
    {
        return YES;
    }else
    {
        return NO;
    }
}
@end
