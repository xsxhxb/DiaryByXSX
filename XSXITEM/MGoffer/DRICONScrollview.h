//
//  DRICONScrollview.h
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@protocol DRICONScrollviewdelegate <NSObject>

-(void)ICONChangenum:(NSInteger) num;

@end

@interface DRICONScrollview : UIScrollView

@property(nonatomic ,weak) id<DRICONScrollviewdelegate> DRdelegate;

@end
