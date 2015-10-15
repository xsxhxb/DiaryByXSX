//
//  FindTableview.m
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//



#import "FindTableview.h"

@implementation FindTableview


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        [self CreatView];
        //[self RuquestData];
    }
    return self;
}

-(void)RuquestData{
    
    [self reloadData];
#if 0
    if (dataarr.count != 0) {
        [self reloadData];
    }else{
    ASIHTTPRequest *findrequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:FindViewURL]];
    findrequest.tag = 10;
    findrequest.delegate = self;
    [findrequest startAsynchronous];
    }
#endif
    
}

#if 0
#pragma -mark ASI数据请求代理
   /*-------------- ASI数据请求代理 ------------ */
- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSDictionary *finddic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
    NSArray *listarr = finddic[@"result"][@"list"];
    //图片视图数据解析
    for (NSDictionary *listdic in listarr) {
        FindViewModel *findmodel = [[FindViewModel alloc] init];
       // FindViewModel *listmodel = [[FindViewModel alloc] init];
        NSArray *contentarr = listdic[@"content"];
        for (NSDictionary *contendic in contentarr) {
            SuperModel *imagemodel = [[SuperModel alloc] init];
            imagemodel.showimage = contendic[@"item_image"];
            imagemodel.showurl = contendic[@"item_uri"];
            [findmodel.imagearr addObject:imagemodel];
        }
        //图片样式
        NSString *type = listdic[@"item_type"];
        findmodel.item_type = type;
        NSString *iconurl = listdic[@"title_icon"];
        findmodel.title_iconurl = iconurl;
        findmodel.title_text = listdic[@"title_text"];
        [dataarr addObject:findmodel];
    }
 
}

#endif

#pragma -mark ASI数据请求失败

- (void)requestFailed:(ASIHTTPRequest *)request{
    Alerk *alerk = [Alerk initWithmessage:@"网络请求失败"];
    [alerk show];

}

-(void)CreatView{

    [self registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.delegate = self;
    self.dataSource = self;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 280;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _dataarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *inde = @"cell";
    FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inde];
    FindViewModel *model = (FindViewModel *)[_dataarr objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

@end
