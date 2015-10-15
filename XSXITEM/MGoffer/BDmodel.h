//
//  BDmodel.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "AGListCellModel.h"

@interface BDmodel : AGListCellModel
//每段数量
@property (nonatomic ,strong) NSMutableArray *Listarr;
@property (nonatomic ,strong) NSString *traclid;
@property (nonatomic ,strong) NSString *key;
@property (nonatomic ,strong) NSString *subTitle;
@property (nonatomic ,assign) NSInteger *RowNum;
-(id)init;
@end
