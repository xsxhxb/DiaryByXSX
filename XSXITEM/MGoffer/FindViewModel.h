//
//  FindViewModel.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperModel.h"

@interface FindViewModel :SuperModel

@property(nonatomic ,strong) NSMutableArray *imagearr;
@property(nonatomic ,strong) NSString *item_type;
@property(nonatomic ,strong) NSString *title_iconurl;
@property(nonatomic ,strong) NSString *title_text;

-(id)init;

@end
