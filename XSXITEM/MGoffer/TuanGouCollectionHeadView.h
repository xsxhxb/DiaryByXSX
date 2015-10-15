//
//  TuanGouCollectionHeadView.h
//  MGoffer
//
//  Created by mac on 14-6-30.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TouGouModel.h"
#import "Common.h"

@interface TuanGouCollectionHeadView : UICollectionReusableView

@property(nonatomic ,strong) NSArray *modelarr;

-(void)setModelarr:(NSArray *)modelarr;

@end
