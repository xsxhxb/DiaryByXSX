//
//  searchTotalData.m
//  MGoffer
//
//  Created by mac on 14-7-6.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "searchTotalData.h"

@implementation searchTotalData


static searchTotalData *searchdata;

+(id)shareSearchData{
    
    if (searchdata == nil) {
        
        searchdata = [[searchTotalData alloc] init];
    }
    return searchdata;
}
-(id)init{

    self = [super init];
    if (self) {
        _searchArr = [NSMutableArray array];
    }
    return self;
}

@end
