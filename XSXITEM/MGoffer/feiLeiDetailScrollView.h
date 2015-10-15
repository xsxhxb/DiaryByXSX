//
//  feiLeiDetailScrollView.h
//  MGoffer
//
//  Created by mac on 14-7-5.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "AIGOUIconModel.h"
#import "paymentlistmodel.h"

@interface feiLeiDetailScrollView : UIScrollView

@property (nonatomic ,strong) AIGOUIconModel *iconModel;
@property (nonatomic ,strong) NSArray *recommendArr;

@property (nonatomic ,assign) BOOL isRecommend;


@end
