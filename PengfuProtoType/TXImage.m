//
//  TXImage.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-16.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXImage.h"

@implementation TXImage
{
    void (^_completionHandler)(UIImage *image,NSURL *url,NSError *error);
    NSURLSessionDownloadTask *_downLoadTask;
    void (^_progressHandle)(int64_t bytesWritten ,int64_t totalBytesWritten ,int64_t totalBytesExpectedToWrite);
}


- (id)initWithURL:(NSURL *)url
{
    self = [self init];
    if (self)
    {
        _url = url;
    }
    return self;
}

- (void)loadImageWithCompletionHandler:(void(^)(UIImage *image,NSURL *url,NSError *error))completionHandler
{
    _completionHandler = completionHandler;
    if (self.image)
    {
        completionHandler(self.image,_url,nil);

    }else if(_downLoadTask)
    {
        
    }else
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForResource = 10;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];

        
        _downLoadTask = [session downloadTaskWithURL:_url];
        

        [_downLoadTask resume];
        
        
    }
    
    
}

- (void)loadImageWithCompletionHandler:(void(^)(UIImage *image,NSURL *url,NSError *error))completionHandler
                        progressHandle:(void(^)(int64_t bytesWritten ,int64_t totalBytesWritten ,int64_t totalBytesExpectedToWrite))progressHandle
{
    [self loadImageWithCompletionHandler:completionHandler];
    _progressHandle = progressHandle;
}
//获取图片缓存路径
- (NSString *)getImageCacheFolderPath
{
    NSString *folderName = @"ImageCache";
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [[cacPath objectAtIndex:0] stringByAppendingPathComponent:folderName];
    return cachePath;
}

//对字符串进行MD5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
#pragma mark - deleget
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
//    NSURL *url = downloadTask.response.URL;
//    NSString *fileName = [self md5:url.path];
//    //文件下载会被先写入到一个 临时路径 location,我们需要将下载的文件移动到我们需要地方保存
//    NSString *savePath = [[self getImageCacheFolderPath] stringByAppendingPathComponent:fileName];
//    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:savePath error:nil];
    NSData *data = [NSData dataWithContentsOfURL:location];
    UIImage *image = [[UIImage alloc]initWithData:data];
    self.image = image;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _completionHandler(image,_url,nil);
        
    });

}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (_progressHandle) {
        _progressHandle(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }
    
    double currentProgress = totalBytesWritten/(double)totalBytesExpectedToWrite;
    NSLog(@"%f",currentProgress);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}


@end
