//
//  paymentlistmodel.h
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paymentlistmodel : NSObject
@property(nonatomic ,strong) NSString *iconimgpng;
@property(nonatomic ,strong) NSString *iconimgjpg;
@property(nonatomic ,strong) NSString *iconname;
@property(nonatomic ,assign) NSInteger iconid;
@property(nonatomic ,strong) NSString *link;
@property(nonatomic ,strong) UIImage *iconnormalimage;
@property(nonatomic ,strong) UIImage *iconselectimage;

@end
