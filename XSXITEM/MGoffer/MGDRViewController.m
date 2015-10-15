//
//  MGDRViewController.m
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "MGDRViewController.h"

@interface MGDRViewController ()

@end

@implementation MGDRViewController{
    UIScrollView *DRBIGScrollview;
    DaPeiView *dapeiview;
    MXDaRenview *darenview;
    SaiHuoDaRenView *saihuoview;
    //搭配达人数据
    NSMutableArray *daPeiArr;
    BOOL isdaPeiFinish;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (daPeiArr == nil) {
        daPeiArr = [NSMutableArray array];
    }
    
    [self requestDaPeiData];
    [self CreatView];
    self.title = @"达人";
    self.automaticallyAdjustsScrollViewInsets = NO;

}

#pragma -mark 请求搭配数据

-(void)requestDaPeiData{

    isdaPeiFinish = NO;
    ASIHTTPRequest *DPrequest = [ASIHTTPRequest requestWithURL:URLSTRING(DRDPURL)];
    
    DPrequest.tag = 10;
    DPrequest.delegate = self;
    
    [DPrequest startAsynchronous];
    
    while (!isdaPeiFinish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}


#pragma -mark ASIHTTPRequest请求数据结束

/*-----------------ASI代理方法接受请求数据-------------------------*/

- (void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag == 10) {
        
        NSDictionary *dpdrdic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *listarr = dpdrdic[@"result"][@"list"];
        
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
            [daPeiArr addObject:model];
        }
        isdaPeiFinish = YES;
    }

}



- (void)requestFailed:(ASIHTTPRequest *)request{
    
    Alerk *alerk = [Alerk initWithmessage:@"网络连接失败"];
    [alerk show];
    
    NSLog(@"网络请求失败");
    
}

#define ICONH 40

-(void)CreatView{

    // 菜单栏
    DRICONScrollview *iconview = [[DRICONScrollview alloc] initWithFrame:CGRectMake(0, 0 , FRAMEW(self.view), ICONH)];
    
    iconview.userInteractionEnabled = YES;
    iconview.DRdelegate = self;
    [self.view addSubview:iconview];
    //总视图
    DRBIGScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(FRAMEX(iconview),FRAMEH(iconview), FRAMEW(iconview), FRAMEH(self.view) -FRAMEH(iconview) - 40)];
    DRBIGScrollview.scrollEnabled = YES;
    DRBIGScrollview.showsHorizontalScrollIndicator = NO;
    DRBIGScrollview.showsVerticalScrollIndicator = NO;
    DRBIGScrollview.bounces = NO;
    DRBIGScrollview.pagingEnabled = YES;
    DRBIGScrollview.contentOffset = CGPointMake(0, FRAMEH(DRBIGScrollview) - 40);
    [self.view addSubview:DRBIGScrollview];

    //搭配达人
    TGCollectionViewlayout *daPeiLayout = [[TGCollectionViewlayout alloc] init];
    daPeiLayout.itemWidth = 150.0f;
    daPeiLayout.columnCount = 2;
    dapeiview = [[DaPeiView alloc] initWithFrame:CGRectMake(0, 0, FRAMEW(DRBIGScrollview), FRAMEH(DRBIGScrollview)) collectionViewLayout:daPeiLayout];
    dapeiview.datasourarr = [daPeiArr copy];
    daPeiLayout.layoutdelegate = dapeiview;
    //晒货达人
    saihuoview = [[SaiHuoDaRenView alloc] initWithFrame:CGRectMake(FRAMEW(DRBIGScrollview) * 1, -30, FRAMEW(DRBIGScrollview), FRAMEH(DRBIGScrollview))];
    
    //明星达人
    darenview = [[MXDaRenview alloc] initWithFrame:CGRectMake( FRAMEW(DRBIGScrollview) * 2, -30, FRAMEW(DRBIGScrollview), FRAMEH(DRBIGScrollview))];
    
    [DRBIGScrollview addSubview:dapeiview];
    [DRBIGScrollview addSubview:saihuoview];
    [DRBIGScrollview addSubview:darenview];
    
    DRBIGScrollview.contentSize = CGSizeMake(320 * 3, FRAMEH(DRBIGScrollview));
    NSLog(@"saihuo frame = %@",saihuoview);
    
    [dapeiview reloadData];
}

#pragma -mark 切换视图
/*--------菜单栏代理方法-------*/

-(void)ICONChangenum:(NSInteger)num{
    
    switch (num) {
        case 0:
            [DRBIGScrollview scrollRectToVisible:CGRectMake(num*320, 64 + 40, 320, 480-64-40) animated:YES];
              [dapeiview reloadDataScourse];
            break;
        case 1:
            [DRBIGScrollview scrollRectToVisible:CGRectMake(num*320,64 + 40, 320, 480-64-40) animated:YES];
            [saihuoview RuquestData];
            break;
        case 2:
            [DRBIGScrollview scrollRectToVisible:CGRectMake(num*320, 64 + 40, 320, 480-64-40) animated:YES];
            [darenview RuquestData];
            break;

        default:
            break;
    }
    
}




@end
