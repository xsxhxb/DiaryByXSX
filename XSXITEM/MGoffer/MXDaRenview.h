//
//  MXDaRenview.h
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ASIHTTPRequest.h"
#import "Alerk.h"
#import "AGListCellModel.h"
#import "DaPeiViewTableViewCell.h"

@interface MXDaRenview : UIView <ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>

//左视图
@property(nonatomic ,strong)  UITableView *Letftableview;
//右视图
@property(nonatomic ,strong)  UITableView *righttableview;

-(void)RuquestData;

@end
