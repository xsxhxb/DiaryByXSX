//
//  AiGouModel.m
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "AiGouModel.h"

@implementation AiGouModel
-(id)init{
    self = [super init];
    if (self) {
        _headimageurl = [[NSMutableArray alloc] init];
        _paymentlist = [[NSMutableArray alloc] init];
        _detailarr = [[NSMutableArray alloc] init];
        _titliconearr = [[NSMutableArray alloc] init];
        _Listarr = [[NSMutableArray alloc] init];
        
    }
    return self;

}
@end
