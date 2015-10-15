//
//  SaiHuoDaRenView.m
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "SaiHuoDaRenView.h"

@implementation SaiHuoDaRenView{
    
    NSMutableArray *datascourarr;
    //左数据源
    NSMutableArray *leftarr;
    //右数据源
    NSMutableArray *rightarr;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatView];
    }
    return self;
}

-(void)CreatView{
    
    if (datascourarr == nil) {
        datascourarr = [NSMutableArray array];
    }
    
    if (leftarr == nil) {
        leftarr = [NSMutableArray array];
    }
    
    if (rightarr == nil) {
        rightarr = [NSMutableArray array];
    }
    //左视图TABLEVIEW
    _Letftableview = [[UITableView alloc] initWithFrame:CGRectMake(5 , 0,FRAMEW(self)/2 - 5- 2.5, FRAMEH(self)) style:UITableViewStyleGrouped];
    _Letftableview.delegate = self;
    _Letftableview.dataSource = self;
    
    
    _righttableview = [[UITableView alloc] initWithFrame:CGRectMake(FRAMEW(self)/2 + 5, 0, FRAMEW(_Letftableview), FRAMEH(self)) style:UITableViewStyleGrouped];
    _righttableview.delegate = self;
    _righttableview.dataSource = self;
    
    [self addSubview:_Letftableview];
    [self addSubview:_righttableview];
    
    
    [_Letftableview registerNib:[UINib nibWithNibName:@"DaPeiViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [_righttableview registerNib:[UINib nibWithNibName:@"DaPeiViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
}

-(void)RuquestData{
    
    //NSString *URLSTR = DRURL(DRDPNUM);
    
    if (datascourarr.count != 0) {
        [_Letftableview reloadData];
        [_righttableview reloadData];
    }else{
        
        ASIHTTPRequest *mxrequest = [ASIHTTPRequest requestWithURL:URLSTRING(DRSHDRURL)];
        
        mxrequest.tag = 10;
        mxrequest.delegate = self;
        
        [mxrequest startAsynchronous];
    }
}


#pragma -mark ASIHTTPRequest请求数据结束

/*-----------------ASI代理方法接受请求数据-------------------------*/

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSDictionary *mxdrdic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *listarr = mxdrdic[@"result"][@"list"];
    
    for (NSDictionary *listdic in listarr) {
        AGListCellModel *model = [[AGListCellModel alloc] init];
        model.cfavnum = [listdic[@"cfav"] integerValue];
        model.cphotonum = [listdic[@"cphoto"] integerValue];
        
        model.showimage = listdic[@"show"][@"img"];
        model.showW = [listdic[@"show"][@"w"] integerValue];
        model.showH = [listdic[@"show"][@"h"] integerValue];
        model.showlargeimage = listdic[@"showLarge"][@"img"];
        model.showlargeW = [listdic[@"showLarge"][@"w"] integerValue];
        model.showlargeH = [listdic[@"showLarge"][@"h"] integerValue];
        NSArray *tagarr = listdic[@"tag"];
        for (NSDictionary *tagdic in tagarr) {
            NSString *tagstr = tagdic[@"text"];
            [model.tagtextarr addObject:tagstr];
        }
        model.title = listdic[@"title"];
        model.trackId = listdic[@"trackId"];
        model.type = listdic[@"type"];
        model.avatar = listdic[@"user"][@"avatar"];
        model.uid = listdic[@"user"][@"uid"];
        model.uname = listdic[@"user"][@"uname"];
        [datascourarr addObject:model];
    }
    
    [self SeparateData];
    
}

#pragma -mark 分割数据源

-(void)SeparateData{
    
    [datascourarr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx % 2 == 0) {
            [rightarr addObject:obj];
        }else{
            [leftarr addObject:obj];
        }
    }];
    
    
    NSLog(@"letf = %i",leftarr.count);
    NSLog(@"rihgt = %i",rightarr.count);
    [_Letftableview reloadData];
    [_righttableview reloadData];
}


- (void)requestFailed:(ASIHTTPRequest *)request{
    
    Alerk *alerk = [Alerk initWithmessage:@"网络连接失败"];
    [alerk show];
    
    NSLog(@"网络请求失败");
    
}


/*--------------tableviewdelegate方法----------------------*/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _Letftableview) {
        
        AGListCellModel *model = leftarr[indexPath.row];
        if (model.cphotonum == 0) {
            return 180 + 5;
            
        }else{
            return 235 + model.titlesize.height;
        }
    }else{
        
        AGListCellModel *model = rightarr[indexPath.row];
        
        if (model.cphotonum == 0) {
            return 180 + 5 ;
        }else{
            return 235 + model.titlesize.height;
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _Letftableview) {
        
        return leftarr.count;
    }else{
        return rightarr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _Letftableview) {
        
        AGListCellModel *model = leftarr[indexPath.row];
        DaPeiViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = model;
        return cell;
        
    }
    else {
        
        AGListCellModel *model = rightarr[indexPath.row];
        DaPeiViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.model = model;
        return cell;
    }
    
}


#pragma -markscrollView代理方法
/*scrollView代理方法实现瀑布流*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSArray *tableviewarr = [NSArray arrayWithObjects:_Letftableview,_righttableview,nil];
    for (UIScrollView *staleview in tableviewarr) {
        if (staleview != scrollView) {
            staleview.contentOffset = scrollView.contentOffset;
        }
    }
    
}

@end
