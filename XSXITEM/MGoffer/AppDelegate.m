//
//  AppDelegate.m
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate{
    UIScrollView *OpenView;
    MytabBarController *mytabbar;
    BOOL AGisfinish;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
#if 0
    int a[10] = {0,1,3,4,3};
    
    //指针数组 数组存放里存放指针
    char * p2[10] = {"11","229","99"};
    
    NSLog(@"p2= %i",*p2[2]);
    
    int *m = nil;
    //数组指针 指向数组的指针
    int (*p)[10];
    p = &a;
    NSLog(@"a = %i",(*p)[3]);
    
#endif
    
    
    _dataarr = [NSMutableArray array];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /* 启动多线程请求数据 传递参数过去*/
    
    [NSThread detachNewThreadSelector:@selector(requestAiGouData) toTarget:self withObject:nil];
    
//    [NSThread detachNewThreadSelector:@selector(requestFeiLeiData) toTarget:self withObject:nil];
//    [NSThread detachNewThreadSelector:@selector(requestDaRenData) toTarget:self withObject:nil];
    
    [self creatOpenImage];
  
    
    //爱购视图
    DEFINE_CONTROLLER(MGAGViewController, AiGouNav);
    //分类视图
    DEFINE_CONTROLLER(MGFLViewController, FeiLeiNav);
    //达人视图
    DEFINE_CONTROLLER(MGDRViewController, DaRenNav);
    //购物车视图
    DEFINE_CONTROLLER(MGGWCViewController, GouWuCheNav);
    //我的视图
    DEFINE_CONTROLLER(MGselfViewController, MYNav);
             /* 导航栏设置   */
    TSset(AiGouNav) = NO;
    TSset(FeiLeiNav) = NO;
    TSset(DaRenNav) = NO;
    TSset(GouWuCheNav) = NO;
    TSset(MYNav) = NO;
    /*  导航设置背景图片 */
    NAVBACIMGE(AiGouNav);
    NAVBACIMGE(FeiLeiNav);
    NAVBACIMGE(DaRenNav);
    NAVBACIMGE(GouWuCheNav);
    NAVBACIMGE(MYNav);
    
    mytabbar = [[MytabBarController alloc] init];
    
    /*tablebar 五大视图控制器*/
    NSDictionary *AiGouDic = [NSDictionary dictionaryWithObjectsAndKeys:
                            AiGouNav,VIEWCONTROL,
                            @"tabbar_icon_home",NORMAL,
                            @"tabbar_icon_home_selected",SELECT,
                            nil];
    NSDictionary *FeiLeiDic = [NSDictionary dictionaryWithObjectsAndKeys:
                            FeiLeiNav,VIEWCONTROL,
                            @"tabbar_icon_cat",NORMAL,
                            @"tabbar_icon_cat_selected",SELECT,
                            nil];
    NSDictionary *DaRenDic = [NSDictionary dictionaryWithObjectsAndKeys:
                            DaRenNav,VIEWCONTROL,
                            @"tabbar_icon_dr",NORMAL,
                            @"tabbar_icon_dr_selected",SELECT,
                            nil];
    NSDictionary *GouWuCheDic = [NSDictionary dictionaryWithObjectsAndKeys:
                            GouWuCheNav,VIEWCONTROL,
                            @"tabbar_cart",NORMAL,
                            @"tabbar_cart_selected",SELECT,
                            nil];
    NSDictionary *MYDic = [NSDictionary dictionaryWithObjectsAndKeys:
                            MYNav,VIEWCONTROL,
                            @"tabbar_icon_profile",NORMAL,
                            @"tabbar_icon_profile_selected",SELECT,
                            nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSArray *tabbararr =  [ NSArray arrayWithObjects:AiGouDic,FeiLeiDic,DaRenDic,GouWuCheDic,MYDic, nil];
    mytabbar.viewControllers = tabbararr;
    NSLog(@"subview = %@",tabbararr);
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
#define OPENIMGW  self.window.bounds.size.width
#define OPENIMGH  self.window.bounds.size.height
#define OPENBTNW  100
#define OPENBTNH  30


#pragma -mark 隐藏Tabbar

-(void)hiddenTabbar{

    CGRect frame = mytabbar.view.frame;
    frame.origin.y = 480;
    
    NSArray *subview = [mytabbar.view subviews];
    for (UIView *view in subview) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UIImageView"]) {
            view.frame = frame;
        }
    }
}
#pragma -mark 显示Tabbar
-(void)disPlayTabbar{
    
    NSLog(@"show");
    CGRect frame = mytabbar.view.frame;
    frame.origin.y = 480-44;
    
    NSArray *subview = [mytabbar.view subviews];
    for (UIView *view in subview) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UIImageView"]) {
            view.frame = frame;
        }
    }
    
}

#pragma -mark 创建开机动画

-(void)creatOpenImage{
    
    OpenView = [[UIScrollView alloc] initWithFrame:self.window.frame];
    OpenView.userInteractionEnabled = YES;
    for (NSInteger i = 0 ; i < 3; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(OPENIMGW * i , 0, OPENIMGW , OPENIMGH)];
        imageview.image = IMAGENAME(@"LaunchImage");
        if (i == 2) {
            imageview.userInteractionEnabled  = YES;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(FRAMEW(imageview)/2 - OPENBTNW/2 , FRAMEH(imageview) - 100, OPENBTNW, OPENBTNH);
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:@"点击进入" forState:BTNNormal];
            //点击结束动画回去主视图
            [btn addTarget:self action:@selector(INTOApp:) forControlEvents:BTNTouchIN];
            [imageview addSubview:btn];
        }
        [OpenView addSubview:imageview];
    }
    OpenView.contentSize = CGSizeMake(OPENIMGW * 3, OPENIMGH);
    OpenView.pagingEnabled = YES;
    OpenView.bounces = NO;
    OpenView.backgroundColor = [UIColor redColor];
    [self.window addSubview:OpenView];

}

#pragma -mark 开机动画结束按钮返回主视图

-(void)INTOApp:(UIButton *)sender{
    

    [sender.superview.superview removeFromSuperview];
    
    if (AGisfinish == NO) {
        [self requestAiGouData];
    }else{
    self.window.rootViewController = mytabbar;
    }
}

#pragma -mark 开机动画启动期间多线程请求数据
//爱购数据
-(void)requestAiGouData{
    AGisfinish = NO;
    NSURL *aigou = [NSURL URLWithString:AIGUANGURL];
    ASIHTTPRequest *aigourequest = [ASIHTTPRequest requestWithURL:aigou];
    aigourequest.delegate = self;
    aigourequest.tag = 10;
    [aigourequest startAsynchronous];
    while (!AGisfinish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}
//分类数据
//-(void)requestFeiLeiData{
//
//    NSURL *fenlei = [NSURL URLWithString:FEILEIURL];
//    ASIHTTPRequest *fenleirequest = [ASIHTTPRequest requestWithURL:fenlei];
//    fenleirequest.delegate = self;
//    fenleirequest.tag = 20;
//    
//    
//}
//达人数据
-(void)requestDaRenData{
    
    NSURL *daren = [NSURL URLWithString:DARENURL];
    ASIHTTPRequest *darenrequest = [ASIHTTPRequest requestWithURL:daren];
    darenrequest.delegate = self;
    darenrequest.tag = 30;
}

#pragma -mark ASI代理方法接受请求数据

/*-----------------ASI代理方法接受请求数据-------------------------*/

- (void)requestFinished:(ASIHTTPRequest *)request{
    switch (request.tag) {
            /*爱购数据解析*/
        case 10:{
            NSDictionary *aigoujson = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        
            AiGouModel *AGmodel = [[AiGouModel alloc] init];
            NSDictionary *result = aigoujson[@"result"];
        
            NSArray *hometabs = result[@"home"][@"tabs"];
               /* 标题scrollview解析 */
            for (NSDictionary *hometabsobj in hometabs) {
                AIGOUIconModel *iconmodel = [[AIGOUIconModel alloc] init];
                iconmodel.normalicon = hometabsobj[@"icon"];
                iconmodel.selecticon = hometabsobj[@"selected"];
                iconmodel.title = hometabsobj[@"title"];
                [AGmodel.titliconearr addObject:iconmodel];
                
            }
                /*  接受支付列表解析  */
            NSArray *payarr = result[@"payment"][@"list"];
            for (NSDictionary *obj in payarr) {
                paymentlistmodel *paymodel = [[paymentlistmodel alloc] init];
                paymodel.iconimgpng = obj[@"img"];
                paymodel.iconname = obj[@"name"];
                paymodel.iconimgjpg = obj[@"img"];
                [AGmodel.paymentlist addObject:paymodel];
            }
            /*接收Wall数据解析*/
           NSArray *headimagearr = result[@"wall"][@"head"];
            for (NSDictionary *headimage in headimagearr) {
                SuperModel *headimagemodel = [[SuperModel alloc] init];
                headimagemodel.showH =[headimage[@"h"] integerValue];
                headimagemodel.showW = [headimage[@"w"] integerValue];
                headimagemodel.showimage = headimage[@"img"];
                [AGmodel.headimageurl addObject:headimagemodel];
            }
             /*  接收list数据解析  */
            NSArray *walllist = result[@"wall"][@"list"];
            
            for (NSInteger i = 0; i < walllist.count; i++) {
                NSDictionary *walllistdic = walllist[i];
                AGListCellModel *AGlistcellmodel = [[AGListCellModel alloc] init];
                if (i == 0) {
                        NSDictionary *operatedic = walllistdic[@"operate"];
                        AGlistcellmodel.showH = [operatedic[@"h"] integerValue];
                        AGlistcellmodel.showW = [operatedic[@"w"] integerValue];
                        AGlistcellmodel.showimage = operatedic[@"img"];
                        
                    }else{
                    //接受首页的详细数据
                    AGlistcellmodel.price = walllistdic[@"price"];
                    AGlistcellmodel.cfavnum = [walllistdic[@"cfav"] integerValue];
                    AGlistcellmodel.title =  walllistdic[@"title"];
                    AGlistcellmodel.showH = [walllistdic[@"show"][@"h"] integerValue];
                    AGlistcellmodel.showW = [walllistdic[@"show"][@"w"] integerValue];
                    AGlistcellmodel.showimage = walllistdic[@"show"][@"img"];
                    AGlistcellmodel.showlargeW = [walllistdic[@"showLarge"][@"w"] integerValue];
                    AGlistcellmodel.showlargeH = [walllistdic[@"showLarge"][@"h"] integerValue];
                    AGlistcellmodel.showlargeimage = walllistdic[@"showLarge"][@"img"];
                    NSArray *arr = walllistdic[@"tag"];
                    for (NSDictionary *tagdic in arr) {
                        NSString *tagstr = tagdic[@"text"];
                        [AGlistcellmodel.tagtextarr addObject:tagstr];
                    }
                }
                [AGmodel.Listarr addObject:AGlistcellmodel];
            }
            /*数据源增加数据*/
            [_dataarr addObject:AGmodel];
            AGisfinish = YES;
        }
    
            break;
             /*分类数据解析*/
        case 20:{
            
            
        }
            break;
            /*达人数据解析*/
        case 30:{
            
        
        }
            break;
            
        default:
            break;
    }


}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    Alerk *alerk = [Alerk initWithmessage:@"请求数据失败请检查网络"];
    [alerk show];
}

@end
