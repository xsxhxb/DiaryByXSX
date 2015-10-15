//
//  BDUITableView.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Common.h"
#import "BDTableViewCell.h"
#import "BDmodel.h"
#import "AIGOUIconModel.h"
#import "Alerk.h"

@interface BDUITableView : UITableView<UITableViewDataSource,UITableViewDelegate>
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
//数据源
@property(nonatomic ,strong) NSArray *dataarr;
//请求数据
-(void)RuquestData;
@end
