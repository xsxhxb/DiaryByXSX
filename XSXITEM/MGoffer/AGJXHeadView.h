//
//  AGJXHeadView.h
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperModel.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@interface AGJXHeadView : UICollectionReusableView
@property(nonatomic ,strong) NSArray *modelarr;

-(void)setModelarr:(NSArray *)modelarr;
@end
