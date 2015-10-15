//
//  FindTableview.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindTableViewCell.h"
#import "ASIHTTPRequest.h"
#import "Common.h"
#import "Alerk.h"
#import "FindViewModel.h"

@interface FindTableview : UITableView<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

//数据源
@property (nonatomic ,strong) NSArray *dataarr;
-(void)RuquestData;

@end
