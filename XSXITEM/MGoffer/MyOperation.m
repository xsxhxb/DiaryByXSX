//
//  MyOperation.m
//  NSOperation
//
//  Created by vera on 14-6-7.
//  Copyright (c) 2014年 vera. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation
{
    BOOL isDownloadOK;
}

- (id)initWithUrl:(NSString *)urlString
{
    self = [super init];
    
    if (self)
    {
        _url = urlString;
        
        receiveData = [NSMutableData data];
    }
    
    return self;
}

- (void)main
{
    NSLog(@"main方法自动调用");
    
    NSURL *url = [NSURL URLWithString:_url];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    
    while (!isDownloadOK)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receiveData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
    
    NSLog(@"第%d个开始 === %d",self.tag,data.length);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"第%d个下载完成",self.tag);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishDownloadWithOpenation:downloadData:)])
    {
        [_delegate didFinishDownloadWithOpenation:self downloadData:[receiveData copy]];
    }
    
    isDownloadOK = YES;
}

@end
