//
//  SuperModel.m
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "SuperModel.h"

@implementation SuperModel
-(id)init{
    self = [super init];
    if (self) {
       // _tagarr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = nil;
        _title = title;
        CGSize titlesize = [_title sizeWithFont:FONT(13.0f) constrainedToSize:CGSizeMake(142.5, 1000)];
        _titlesize = titlesize;

    }
}


@end
