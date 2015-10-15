//
//  TouGouModel.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "SuperModel.h"

@interface TouGouModel : SuperModel

//商品介绍
@property(nonatomic ,strong) NSString *intro;
//团购总数
@property(nonatomic ,assign) NSInteger boughtTotal;
@property(nonatomic ,assign) NSInteger start;
@property(nonatomic ,strong) NSMutableArray *HeadViewarr;
@property(nonatomic ,strong) NSString *discount;
@property(nonatomic ,strong) NSMutableArray *listarr;
-(id)init;

@end
