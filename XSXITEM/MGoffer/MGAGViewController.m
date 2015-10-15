//
//  MGAGViewController.m
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "MGAGViewController.h"

@interface MGAGViewController ()


@end

@implementation MGAGViewController{
    UIScrollView *ICONScrollview;
    UIScrollView *JXScrollview;
    UIScrollView *JXBigScrollview;
    //精选数据源
    AiGouModel *JXAGmodel;
    //俩个个tableview联动实现瀑布流d
    AGJXView *JXAGCollectionView;
    NSInteger currentpage;
    NSMutableArray *_JXdataScourse;
    //精选是否加载完成
    BOOL _isJXfish;
    //发现TableView
    FindTableview *findtableview;
    NSMutableArray *findarr;
    BOOL isFindFinish;
    //榜单TableView
    BDUITableView *bangdantableview;
    NSMutableArray *bangdanarr;
    BOOL isBangDanfinish;
     //团购collectionview
    TuanGouCollecTionView *tgcollectionview;
    NSMutableArray *tuangouarr;
    NSMutableArray *tuanGouIconArr;
    BOOL isTuanGouFinish;
    //标题图片
    NSMutableArray *iconarr;
    BOOL isfinish;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define NAVH 64
#define ICONSH 39


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"蘑菇街";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (_JXdataScourse == nil) {
        _JXdataScourse = [NSMutableArray array];
    }
    if (findarr == nil) {
        findarr = [NSMutableArray array];
    }
    if (bangdanarr == nil) {
        bangdanarr = [NSMutableArray array];
    }
    if (tuangouarr == nil) {
        tuangouarr = [NSMutableArray array];
        tuanGouIconArr = [NSMutableArray array];
    }
    iconarr = [NSMutableArray array];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    JXAGmodel = [delegate.dataarr firstObject];
    
    [self crestToTalView];
    [self requesticonimage];
    
    [self CrestHeadIconView];
    [self ReloadView];
    
}

#pragma -mark 创建总视图

-(void)crestToTalView{

    //标题视图
    ICONScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0 , FRAMEW(self.view), ICONSH)];
    ICONScrollview.backgroundColor = [UIColor colorWithPatternImage:IMAGENAME(@"cart_shop_bg")];
 
    ICONScrollview.userInteractionEnabled = YES;

    //总的大视图
    JXBigScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, FRAMEY(ICONScrollview), FRAMEW(self.view), FRAMEH(self.view)-64 - 40)];
    [JXBigScrollview addSubview:JXScrollview];
    JXBigScrollview.scrollEnabled = YES;
    JXBigScrollview.bounces = NO;
    JXBigScrollview.pagingEnabled = YES;
    JXBigScrollview.showsHorizontalScrollIndicator = NO;
    JXBigScrollview.showsVerticalScrollIndicator = NO;
     //精选视图
    TGCollectionViewlayout *AGJXLayout = [[TGCollectionViewlayout alloc] init];
    [AGJXLayout setHeaderReferenceSize:CGSizeMake(320,165)];
    AGJXLayout.columnCount = 2;
    AGJXLayout.itemWidth = 150.0f;
    
    JXAGCollectionView = [[AGJXView alloc] initWithFrame:CGRectMake(0, 20, FRAMEW(self.view), FRAMEH(self.view) - 65)  collectionViewLayout:AGJXLayout];
    JXAGCollectionView.AGJXdelegate = self;
    AGJXLayout.layoutdelegate = JXAGCollectionView;
    JXAGCollectionView.receiveModel = JXAGmodel;
    [JXBigScrollview addSubview:JXAGCollectionView];
    JXBigScrollview.delegate = self;
    
    //发现视图
    findtableview = [[FindTableview alloc] initWithFrame:CGRectMake(320, 20, FRAMEW(self.view), FRAMEH(self.view)) style:UITableViewStyleGrouped];
    [JXBigScrollview addSubview:findtableview];
    
    //榜单视图
    bangdantableview = [[BDUITableView alloc] initWithFrame:CGRectMake(320 * 2, 20, FRAMEW(self.view), FRAMEH(self.view) - 20) style:UITableViewStyleGrouped];
    [JXBigScrollview addSubview:bangdantableview];
    
    //团购视图
    TGCollectionViewlayout *tglayout = [[TGCollectionViewlayout alloc] init];
    [tglayout setHeaderReferenceSize:CGSizeMake(320,120)];
    tglayout.columnCount = 2;
    tglayout.itemWidth = 150.0f;
    tgcollectionview = [[TuanGouCollecTionView alloc] initWithFrame:CGRectMake(320 * 3, 20, FRAMEW(self.view), FRAMEH(self.view) - 65)  collectionViewLayout:tglayout];
    
    tglayout.layoutdelegate = tgcollectionview;
     
    [JXBigScrollview addSubview:tgcollectionview];

    JXBigScrollview.contentSize = CGSizeMake(320 * 4, FRAMEH(JXBigScrollview));
    
    [self.view addSubview:JXBigScrollview];
    [self.view addSubview:ICONScrollview];

}

#pragma -mark 请求iconimage数据
-(void)requesticonimage{
    
    
    isfinish = NO;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置最大下载的个数
    queue.maxConcurrentOperationCount = 1;

    for (NSInteger i = 0; i < JXAGmodel.titliconearr.count; i++) {
        AIGOUIconModel *iconmodel = JXAGmodel.titliconearr[i];
        MyOperation *Noperation = [[MyOperation alloc] initWithUrl:iconmodel.normalicon];
        Noperation.tag = i;
        MyOperation *Soperation = [[MyOperation alloc] initWithUrl:iconmodel.selecticon];
        Soperation.tag = i + 10;
        Noperation.delegate = self;
        Soperation.delegate = self;
        //添加任务
        [queue addOperation:Noperation];
        [queue addOperation:Soperation];
    }
    
    while (!isfinish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
   
}

#pragma -mark 数据请求
-(void)RuquestFindData{

    ASIHTTPRequest *findrequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:FindViewURL]];
    findrequest.tag = 10;
    findrequest.delegate = self;
    [findrequest startAsynchronous];

}

-(void)requestBangDanData{

        ASIHTTPRequest *BDrequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:BanDanURL]];
        BDrequest.tag = 20;
        BDrequest.delegate = self;
        [BDrequest startAsynchronous];

}


-(void)reuestTuanGouData{

    ASIHTTPRequest *TuanGourequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:TuanGouURL]];
    TuanGourequest.tag = 30;
    TuanGourequest.delegate = self;
    [TuanGourequest startAsynchronous];
    
}


#pragma mark -MyOperationDelegate

- (void)didFinishDownloadWithOpenation:(MyOperation *)operation downloadData:(NSData *)downlaodData
{
    
    UIImage *iconimage = IMAGEDATA(downlaodData);
    [iconarr addObject:iconimage];
    NSLog(@"%d",operation.tag);
    if (operation.tag == 10 +  JXAGmodel.titliconearr.count-1 ) {
         isfinish = YES;
    }
}

#pragma -mark ASIHTTPRequest请求数据结束

/*-----------------ASI代理方法接受请求数据-------------------------*/

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    if (request.tag == 1) {
            NSDictionary *aigoujson = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
            
            AiGouModel *AGmodel = [[AiGouModel alloc] init];
            NSDictionary *result = aigoujson[@"result"];

            /*  接收list数据解析  */
            NSArray *walllist = result[@"list"];
            
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
            [_JXdataScourse addObject:AGmodel];
            _isJXfish = YES;
        }
    //发现视图数据
    else if (request.tag == 10) {
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
            [findarr addObject:findmodel];
            isFindFinish = YES;
        }
    }else if (request.tag == 20){
      //榜单数据源请求
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
            [bangdanarr addObject:bdmodelBig];
        }
        isBangDanfinish = YES;
    }else if (request.tag == 30){

        NSDictionary *TuanGouDic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        TouGouModel *tuanGoumodel = [[TouGouModel alloc] init];
        NSArray *catearr = TuanGouDic[@"result"][@"cate"];
        
        for (NSDictionary *catedic in catearr) {
            //接受弹出菜单视图
            SuperModel *catemodel = [[SuperModel alloc] init];
            catemodel.showimage = catedic[@"image"];
            catemodel.title = catedic[@"value"];
            [tuanGouIconArr addObject:catemodel];
        }
        NSArray *headarr = TuanGouDic[@"result"][@"head"];
        for (NSDictionary *headdic in headarr) {
            SuperModel *headmodel = [[SuperModel alloc] init];
            headmodel.showimage = headdic[@"img"];
            headmodel.showH = [headdic[@"h"] integerValue];
            headmodel.showW = [headdic[@"w"] integerValue];
            [tuanGoumodel.HeadViewarr addObject:headmodel];
        }
        //详细列表数据
        NSArray *listarr = TuanGouDic[@"result"][@"list"];
        for (NSDictionary *listdic in listarr) {
            TouGouModel *listmodel = [[TouGouModel alloc] init];
            listmodel.boughtTotal = [listdic[@"boughtTotal"] integerValue];
            listmodel.discount = listdic[@"discount"];
            listmodel.intro = listdic[@"intro"];
            listmodel.price = listdic[@"nowPrice"];
            listmodel.oldPrice = listdic[@"oldPrice"];
            //小图
            listmodel.showW = [listdic[@"show"][@"w"] integerValue];
            listmodel.showH = [listdic[@"show"][@"h"] integerValue];
            listmodel.showimage = listdic[@"show"][@"img"];
            //大图
            listmodel.showlargeH = [listdic[@"showLarge"][@"h"] integerValue];
            listmodel.showlargeW = [listdic[@"showLarge"][@"w"] integerValue];
            listmodel.showlargeimage = listdic[@"showLarge"][@"img"];
            listmodel.start = [listdic[@"start"] integerValue];
            listmodel.title = listdic[@"title"];
            listmodel.trackId = listdic[@"trackId"];
            //店铺网址
            listmodel.ShopUrl = listdic[@"url"];
            [tuanGoumodel.listarr addObject:listmodel];
        }
        [tuangouarr addObject:tuanGoumodel];
        isTuanGouFinish = YES;
    }

}
- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"网络请求失败");

}
#pragma -mark 首页Icon菜单装载数据
#define ICONLABERW 40

-(void)CrestHeadIconView{
    
        UIImage *image = [iconarr firstObject];
        NSInteger BTNW = image.size.width;
        NSInteger BTNH = image.size.height;
        NSInteger j = 0;
    
    if (isfinish == NO) {
        [self requesticonimage];
        return;
    }
    
    NSLog(@"jx =  %i",JXAGmodel.titliconearr.count);
    
    for (NSInteger i = 0; i < JXAGmodel.titliconearr.count; i++) {
        
        AIGOUIconModel *iconmodel = JXAGmodel.titliconearr[i];
        //icon图片按钮
        UIButton *iconbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconbtn.tag = i + 1;
        //icon图片文字
        UILabel *laber = [[UILabel alloc] init];
        iconbtn.frame = CGRectMake(10 + FRAMEW(ICONScrollview)/4 * i,(FRAMEH(ICONScrollview)-BTNH/2)/2, BTNW/2, BTNH/2);
        laber.frame = CGRectMake(FRAMEX(iconbtn) + FRAMEW(iconbtn) + 3, FRAMEY(iconbtn), ICONLABERW, FRAMEH(iconbtn));
        laber.backgroundColor = CCCLOR;
        
        UIImage *imagenormal = iconarr[j];
        [iconbtn setImage:imagenormal forState:BTNNormal];
        UIImage *imageselect = iconarr[(j+1)];
        j = j+2;
        [iconbtn setImage:imageselect forState:BTNSelect];
        [iconbtn addTarget:self action:@selector(VIewSelect:) forControlEvents:BTNTouchIN];
        laber.text = iconmodel.title;
        laber.textAlignment = NSTextAlignmentLeft;
        laber.tag = 10 + i + 1;
        [ICONScrollview addSubview:iconbtn];
        [ICONScrollview addSubview:laber];
    }
    
    NSLog(@"count = %i",ICONScrollview.subviews.count);
  
}


#pragma -mark 选择Icon视图切换菜单UI

-(void)VIewSelect:(UIButton *)sender{

   for (NSInteger i = 0; i < JXAGmodel.titliconearr.count; i++) {
       NSInteger k = i + 1;
       NSInteger m = 10 + i + 1;
       UIButton *btn = (UIButton *)[ICONScrollview viewWithTag:k];
       UILabel *laber =  (UILabel *)[ICONScrollview viewWithTag:m];
       btn.selected = NO;
       laber.textColor = BLACKCLOR;
    }
    sender.selected = YES;
    UILabel *laber =  (UILabel *)[ICONScrollview viewWithTag:sender.tag + 10];
    laber.textColor = REDCLOR;
    currentpage = sender.tag - 1;
    NSLog(@"currentpage = %i",currentpage);
    [self ReloadView];

}

#pragma -mark 加载所选择的视图
-(void)ReloadView{
  
    switch (currentpage) {
        case 0:{
            [JXBigScrollview scrollRectToVisible:CGRectMake(currentpage*320, 40, 320, 480-64-40) animated:YES];
           // JXBigScrollview.contentOffset =CGPointMake(currentpage*320,-20);
            [JXAGCollectionView reloadDatascorse];
            break;
        }
        case 1:{

            [JXBigScrollview scrollRectToVisible:CGRectMake(currentpage*320, 40, 320, 480-64-40) animated:YES];
            if (findarr.count == 0) {
                [self RuquestFindData];
                while (!isFindFinish) {
                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                }
            }
                findtableview.dataarr = [findarr copy];
                [findtableview RuquestData];
          
             // JXBigScrollview.contentOffset =CGPointMake(currentpage*320,20);
            break;
        }
        case 2:{
            [JXBigScrollview scrollRectToVisible:CGRectMake(currentpage*320, 40, 320, 480-64-40) animated:YES];
            if (bangdanarr.count == 0) {
                [self requestBangDanData];
                while (!isBangDanfinish) {
                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                }
            }
                bangdantableview.dataarr = bangdanarr;
                [bangdantableview RuquestData];
 
           // JXBigScrollview.contentOffset =CGPointMake(currentpage * 320,20);
            break;
        }
        case 3:{
            
            if (tuangouarr.count == 0) {
                [self reuestTuanGouData];
                while (!isTuanGouFinish) {
                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                }
            }
            tgcollectionview.datasourarr = tuangouarr;
            [JXBigScrollview scrollRectToVisible:CGRectMake(currentpage*320, 40, 320, 480-64-40) animated:YES];
            [tgcollectionview RuquestData];
           // JXBigScrollview.contentOffset =CGPointMake(currentpage*320,-20);
            break;
        }
        default:
            break;
    }
}

//#pragma -markscrollView代理方法
///*scrollView代理方法视图转换*/
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    currentpage = scrollView.contentOffset.x/ FRAMEW(scrollView);
//    [self ReloadView];
//}


#pragma -精选下拉刷新代理方法
-(void)reFreshCollectionView:(NSInteger)page{
    
    _isJXfish = NO;
    NSString *jxstr = [NSString stringWithFormat:@"%@%@%@",AIGOUJXPULLREFRESH,JXONEPAGE,AGJXBOOK];

    ASIHTTPRequest *aigourequest = [ASIHTTPRequest requestWithURL:URLSTRING(jxstr)];
    aigourequest.delegate = self;
    aigourequest.tag = 1;
    [aigourequest startAsynchronous];
    while (!_isJXfish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    for (NSInteger i = 0; i < _JXdataScourse.count; i++) {
        AiGouModel *JXModel = (AiGouModel *)[_JXdataScourse objectAtIndex:i];
        for (AGListCellModel *model in JXModel.Listarr) {
            
            [JXAGmodel.Listarr addObject:model];
        }
    }
    
    currentpage = 0;
    
    JXAGCollectionView.receiveModel = JXAGmodel;
    [self ReloadView];
    
}




#if 0
#pragma -mark 首页大图装载数据


-(void)CrestHeadView{
    
    SuperModel *model = [JXAGmodel.headimageurl firstObject];
    for (NSInteger i = 0; i < JXAGmodel.headimageurl.count; i++) {
        SuperModel *headmodel = JXAGmodel.headimageurl[i];
        UIImageView *headimageview = [[UIImageView alloc] initWithFrame:CGRectMake(headmodel.showW * i, 0, headmodel.showW, headmodel.showH)];
        [headimageview setImageWithURL:[NSURL URLWithString:headmodel.showimage]];
        [JXScrollview addSubview:headimageview];
    }
    JXScrollview.frame = CGRectMake(0, FRAMEH(ICONScrollview), FRAMEW(self.view), model.showH);
    JXScrollview.contentSize = CGSizeMake(model.showW * JXAGmodel.headimageurl.count, model.showH);
    JXScrollview.pagingEnabled = YES;
    JXScrollview.showsHorizontalScrollIndicator = NO;
    JXScrollview.showsVerticalScrollIndicator = NO;
    JXScrollview.bounces = NO;
    
    //设置JXBigScrollview的ContentView;
   // JXBigScrollview.contentSize = CGSizeMake(FRAMEW(self.view), FRAMEH(JXBigScrollview) + FRAMEH(JXScrollview));

}


#pragma -mark 创建瀑布流
#define TABLEW 320/2
-(void)CrestTableView{
    
    Letftableview = [[JXTableView alloc] initWithFrame:CGRectMake(0, FRAMEY(JXScrollview) + FRAMEH(JXScrollview), TABLEW , FRAMEH(JXBigScrollview) - FRAMEH(JXScrollview)) style:UITableViewStyleGrouped];
    righttableview = [[JXRightTbaleview alloc] initWithFrame:CGRectMake(TABLEW , FRAMEY(JXScrollview) + FRAMEH(JXScrollview), TABLEW, FRAMEH(JXBigScrollview) - FRAMEH(JXScrollview)) style:UITableViewStylePlain];
    Letftableview.scrollEnabled = YES;
    Letftableview.showsHorizontalScrollIndicator = NO;
    Letftableview.showsVerticalScrollIndicator = NO;
    Letftableview.delegate = self;
  //  Letftableview.directionalLockEnabled = YES;
    Letftableview.tag = 50;
    [JXBigScrollview addSubview:Letftableview];
    
    righttableview.tag = 60;
   // righttableview.directionalLockEnabled  = YES;
    righttableview.showsHorizontalScrollIndicator = NO;
    righttableview.delegate = self;
    righttableview.showsVerticalScrollIndicator = NO;
    [JXBigScrollview addSubview:righttableview];
}


#endif

@end
