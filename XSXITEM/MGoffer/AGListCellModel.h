//
//  AGListCellModel.h
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperModel.h"

@interface AGListCellModel : SuperModel

@property (nonatomic ,strong) NSMutableArray *tagtextarr;
@property (nonatomic ,assign) NSInteger cfavnum;
/*达人视图控制器延伸数据模型*/
//个人小图标
@property (nonatomic ,strong) NSString *avatar;
@property (nonatomic ,strong) NSString *uname;
@property (nonatomic ,strong) NSString *uid;
@property (nonatomic ,assign) NSInteger cphotonum;
@property (nonatomic ,assign) BOOL isFirst;

-(id)init;

@end
