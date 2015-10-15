//
//  BDUITableView.m
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "BDUITableView.h"

@implementation BDUITableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self CreatView];

    }
    return self;
}
#pragma -mark 创建视图
-(void)CreatView{
    
    [self registerNib:[UINib nibWithNibName:@"BDTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.delegate = self;
    self.dataSource = self;
    
}

-(void)RuquestData{

    [self reloadData];

}



#define ROWH 142

#pragma -mark tableView代理方法实现
/*tableView代理方法实现*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ROWH;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataarr.count;
}

#define SECTIONH 52


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SECTIONH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BDmodel *model = _dataarr[section];
    //三个视图是一行
    return model.Listarr.count;
}

#define SECTIONW 300
#define SECTIONLABERW 120
#define SECTIONLABERH 22
#define SEbottomLABERH 19
#define SECTIONBTNW 100
#define SECTIONBTNH 52

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionheadview = [[UIView alloc] initWithFrame:CGRectZero];
    NSString *bakstr = [NSString stringWithFormat:@"rank_title_bg%i",section];
    UIImage *bcimage = IMAGENAME(bakstr);
    sectionheadview.frame = CGRectMake(0, 0, bcimage.size.width, bcimage.size.height);
   // sectionheadview.clipsToBounds = YES;
    sectionheadview.backgroundColor = WHITECOLOR;
    //背景图片设置
    UIImageView *backimageview = [[UIImageView alloc] initWithFrame:sectionheadview.frame];
    backimageview.image = bcimage;
    UILabel *Sectionlaber = [[UILabel alloc] initWithFrame:CGRectMake(20,8, SECTIONLABERW, SECTIONLABERH)];
    UILabel *Sbottomlaber = [[UILabel alloc] initWithFrame:CGRectMake(FRAMEX(Sectionlaber),FRAMEY(Sectionlaber)+FRAMEH(Sectionlaber),SECTIONLABERW, SEbottomLABERH)];
    UIButton *morebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    morebtn.frame = CGRectMake( FRAMEW(sectionheadview) - SECTIONBTNW , 0 , SECTIONBTNW, SECTIONBTNH);
    [morebtn setTitle:@"查看更多 >" forState:BTNNormal];
    [morebtn addTarget:self action:@selector(DisPlayMore:) forControlEvents:BTNTouchIN];
     morebtn.titleLabel.textColor = WHITECOLOR;
    Sectionlaber.textColor = WHITECOLOR;
    Sbottomlaber.textColor = WHITECOLOR;
    morebtn.titleLabel.font  = FONT(14.0f);
    Sectionlaber.backgroundColor  = CCCLOR;
    Sbottomlaber.backgroundColor = CCCLOR;
    morebtn.backgroundColor = CCCLOR;
    //取段头数据
    BDmodel *model =  _dataarr[section];
    Sectionlaber.text = model.title;
    Sectionlaber.font = FONT(14.0f);
    Sbottomlaber.text = model.subTitle;
    Sbottomlaber.font = FONT(12.5f);
    [sectionheadview addSubview:backimageview];
    [sectionheadview addSubview:Sectionlaber];
    [sectionheadview addSubview:Sbottomlaber];
    [sectionheadview addSubview:morebtn];
    return sectionheadview;

}

#pragma -mark 点击段头查看更多

-(void)DisPlayMore:(UIButton *)sender{

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *inde = @"cell";
    BDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inde];
    //这是一个BDmodel大的每个list 由三个BDmodel
    BDmodel *model = (BDmodel *)[_dataarr objectAtIndex:indexPath.section];
    BDmodel *cellmodel = model.Listarr[indexPath.row];
    
    if ( indexPath.row == 0) {
        cell.isTopRow = YES;
    }else{
        cell.isTopRow = NO;
    }
 
    NSLog(@"section = %i,row = %i",indexPath.section,indexPath.row);
    cell.model = cellmodel;
    return cell;
}

#if 0
#pragma -mark ASI数据请求代理
/*-------------- ASI数据请求代理 ------------ */
- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSDictionary *finddic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
    NSArray *listarr = finddic[@"result"][@"list"];
    //图片视图数据解析
    for (NSDictionary *listdic in listarr) {
        
        //每一段
        BDmodel *bdmodelBig = [[BDmodel alloc] init];
        
        NSArray *contentarr = listdic[@"list"];
        for (NSInteger j = 0 ; j< contentarr.count/3 ; j++) {
            
            //每三个建一个MODEL总数就是行数
            BDmodel *bdmodel = [[BDmodel alloc] init];
            
            for (NSInteger i = j * 3 ; i< (j+1) * 3 ; i++) {
                //行数的单元格
                AGListCellModel *bdimagemodel = [[AGListCellModel alloc] init];
                NSDictionary *contendic =  contentarr[i];
                bdimagemodel.cfavnum = [contendic[@"cfav"] integerValue];
                bdimagemodel.gid = contendic[@"gid"];
                bdimagemodel.iid = contendic[@"iid"];
                bdimagemodel.price = contendic[@"price"];
                bdimagemodel.title = contendic[@"title"];
                bdimagemodel.type = contendic[@"type"];
                //展示图
                bdimagemodel.showimage = contendic[@"show"][@"img"];
                bdimagemodel.showW = [contendic[@"show"][@"w"] integerValue];
                bdimagemodel.showH = [contendic[@"show"][@"h"] integerValue];
                
                
                //大图片
                bdimagemodel.showlargeimage = contendic[@"showLarge"][@"img"];
                bdimagemodel.showlargeW = [contendic[@"showLarge"][@"w"] integerValue];
                bdimagemodel.showlargeH = [contendic[@"showLarge"][@"h"] integerValue];
                
                [bdmodel.Listarr addObject:bdimagemodel];
                NSArray *tagarr = contendic[@"tag"];
                for (NSDictionary *tagdic in tagarr) {
                    AIGOUIconModel *bdicon = [[AIGOUIconModel alloc] init];
                    bdicon.text = tagdic[@"text"];
                    bdicon.type = tagdic[@"type"];
                    [bdmodel.tagtextarr addObject:bdicon];
                }
            }
            [bdmodelBig.Listarr addObject:bdmodel];
        }
        //图片样式
        bdmodelBig.title = listdic[@"title"];
        bdmodelBig.subTitle = listdic[@"subTitle"];
        [dataarr addObject:bdmodelBig];
    }
    BDmodel *modelss = (BDmodel *)[dataarr objectAtIndex:0];
    BDmodel *cellmodelss = modelss.Listarr[0];
    NSArray *arr = cellmodelss.Listarr;
    for (AGListCellModel *modelimager in arr) {
        NSLog(@"imaegurl = %@",modelimager.showimage);
    }
    [self reloadData];
}

#endif

@end
