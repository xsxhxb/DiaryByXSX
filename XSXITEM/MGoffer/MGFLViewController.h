//
//  MGFLViewController.h
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Alerk.h"
#import "AIGOUIconModel.h"
#import "paymentlistmodel.h"
#import "FeiLeiMenuView.h"
#import "feiLeiDetailScrollView.h"
#import "Common.h"
#import "MyOperation.h"
#import "FLSearchDisplay.h"
#import "searchResultTableViewCell.h"
#import "searchViewController.h"
#import "searchTotalData.h"


@interface MGFLViewController : UIViewController<ASIHTTPRequestDelegate,FeiLeiMenuViewdelegate,MyOperationDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end
