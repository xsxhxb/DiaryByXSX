//
//  AiGouModel.h
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "SuperModel.h"

@interface AiGouModel : NSObject
//首页八张图
@property (nonatomic , strong) NSMutableArray *headimageurl;
//支付列表
@property (nonatomic , strong) NSMutableArray *paymentlist;
@property (nonatomic , strong) NSMutableArray *detailarr;
//滚动菜单
@property (nonatomic , strong) NSMutableArray *titliconearr;
//详细信息
@property (nonatomic , strong) NSMutableArray *Listarr;
@property (nonatomic , strong) NSString *img4iphone;
@property (nonatomic , assign) NSInteger start;
@property (nonatomic , strong) NSString *status;
-(id)init;


@end
