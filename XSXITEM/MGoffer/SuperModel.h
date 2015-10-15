//
//  SuperModel.h
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface SuperModel : NSObject

@property (nonatomic ,assign) NSInteger showW;
@property (nonatomic ,assign) NSInteger showH;
@property (nonatomic ,strong) NSString *showimage;
@property (nonatomic ,strong) NSString *showurl;
@property (nonatomic ,strong) NSString *showlargeimage;
@property (nonatomic ,assign) NSInteger showlargeH;
@property (nonatomic ,assign) NSInteger showlargeW;
@property (nonatomic ,strong) NSString *price;
@property (nonatomic ,strong) NSString *oldPrice;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *gid;
@property (nonatomic ,strong) NSString *iid;
@property (nonatomic ,strong) NSString *trackId;
@property (nonatomic ,strong) NSString *ShopUrl;
@property (nonatomic ,assign) CGSize titlesize;

-(id)init;

-(void)setTitle:(NSString *)title;

@end
