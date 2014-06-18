//
//  TXImage.h
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-16.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXImage : NSObject <NSURLSessionDownloadDelegate>
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic) CGSize size;


- (id)initWithURL:(NSURL *)url;
- (void)loadImageWithCompletionHandler:(void(^)(UIImage *image,NSURL *url,NSError *error))completionHandler;
- (void)loadImageWithCompletionHandler:(void(^)(UIImage *image,NSURL *url,NSError *error))completionHandler
                        progressHandle:(void(^)(int64_t bytesWritten ,int64_t totalBytesWritten ,int64_t totalBytesExpectedToWrite))progressHandle;

@end
