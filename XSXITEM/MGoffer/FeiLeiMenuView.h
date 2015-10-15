//
//  FeiLeiMenuView.h
//  MGoffer
//
//  Created by mac on 14-7-1.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperModel.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "paymentlistmodel.h"
#import "AIGOUIconModel.h"

@protocol FeiLeiMenuViewdelegate <NSObject>

-(void)FeiLeiMenuViewChange:(NSInteger)num;

@end

@interface FeiLeiMenuView : UIView

@property(nonatomic ,strong) SuperModel *model;
@property(nonatomic ,strong) NSArray *menuArr;
@property(nonatomic ,weak) id<FeiLeiMenuViewdelegate>delegate;



@end
