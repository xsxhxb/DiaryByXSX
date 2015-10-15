//
//  AppDelegate.h
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MGselfViewController.h"
#import "MGDRViewController.h"
#import "MGFLViewController.h"
#import "MGAGViewController.h"
#import "MGGWCViewController.h"
#import "MytabBarController.h"
#import "ASIHTTPRequest.h"
#import "Alerk.h"
#import "AiGouModel.h"
#import "AGListCellModel.h"
#import "AIGOUIconModel.h"
#import "paymentlistmodel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,ASIHTTPRequestDelegate>


@property (strong, nonatomic) UIWindow *window;
//请求数据源
@property (strong ,nonatomic) NSMutableArray *dataarr;

-(void)hiddenTabbar;
-(void)disPlayTabbar;

@end
