//
//  MGAGViewController.h
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AiGouModel.h"
#import "AIGOUIconModel.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "ASIHTTPRequest.h"
#import "Common.h"
#import "MyOperation.h"
#import "FindTableview.h"
#import "BDUITableView.h"
#import "TuanGouCollecTionView.h"
#import "TGCollectionViewlayout.h"
#import "AGJXView.h"
#import "searchTotalData.h"




@interface MGAGViewController : UIViewController<ASIHTTPRequestDelegate,MyOperationDelegate,UIScrollViewDelegate,UITableViewDelegate,AGJXViewdelegate>

@end
