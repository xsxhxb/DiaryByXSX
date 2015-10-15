//
//  MyOperation.h
//  NSOperation
//
//  Created by vera on 14-6-7.
//  Copyright (c) 2014年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyOperation;

@protocol MyOperationDelegate <NSObject>

- (void)didFinishDownloadWithOpenation:(MyOperation *)operation downloadData:(NSData *)downlaodData;


@end

@interface MyOperation : NSOperation<NSURLConnectionDataDelegate>
{
    NSString *_url;
    NSMutableData *receiveData;
}

@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,assign) id<MyOperationDelegate> delegate;

- (id)initWithUrl:(NSString *)urlString;

@end
