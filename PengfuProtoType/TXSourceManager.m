//
//  TXSourceManager.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-16.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXSourceManager.h"
#import "TXPostsData.h"
#import "TXIterator.h"
#import "TXImage.h"
#import "TXContentItem.h"

@implementation TXSourceManager
+ (NSArray *)getPosterList
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"PosterList" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *resultList = [self getPostsDataWithList:jsonList];
    return resultList;
}


+ (NSArray *)getPostsDataWithList:(NSArray *) list
{

    NSMutableArray *resault = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in list) {
        TXPostsData *data = [[TXPostsData alloc]init];
        data.name = dic[@"name"];
        data.avatar = dic[@"avatar"];
        data.numTop = [dic[@"numTop"]integerValue];
        data.numTread = [dic[@"numTread"]integerValue];
        data.date = [NSDate dateWithTimeIntervalSince1970:[dic[@"date"]longLongValue]/1000];
        NSMutableArray *contentList = [[NSMutableArray alloc]init];
        for (NSDictionary *contentDic in dic[@"content"])
        {

            TXContentItem *content = [[TXContentItem alloc]init];
            if ([contentDic objectForKey:@"image"])
            {
                NSURL *url = [NSURL URLWithString:[contentDic objectForKey:@"image"]];
                TXImage *image = [[TXImage alloc]initWithURL:url];
                image.size = CGSizeMake([contentDic[@"width"]integerValue], [contentDic[@"height"]integerValue]);
                
                content.item = image;
                content.type = TX_CONTENT_PICTURE;
                [contentList addObject:content];
            }else if ([contentDic objectForKey:@"str"])
            {
                content.item = [contentDic objectForKey:@"str"];
                content.type = TX_CONTENT_JOKE;
                [contentList addObject:content];
            }
            
        }
        data.commentList = [self getPostsDataWithList:dic[@"comment"]];
        [data addContentList:contentList];
        
        [resault addObject:data];
    }

    return resault;
}


@end
