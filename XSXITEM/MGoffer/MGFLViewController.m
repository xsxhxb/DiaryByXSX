//
//  MGFLViewController.m
//  MGoffer
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "MGFLViewController.h"

@interface MGFLViewController (){

    NSMutableArray *_feiLeiDataScourse;
    //判断是否请求结束
    BOOL isFeiLeiFinish;
    NSMutableArray *_feiLeiTuiJianarr;
    feiLeiDetailScrollView *detailview;
    BOOL isIconFinish;
    NSMutableArray *_iconArr;
    NSMutableArray *_iconScourse;
    searchViewController *searchview;
    NSMutableArray *_searchResultArr;
    UISearchDisplayController *displaySearch;
}

@end

@implementation MGFLViewController

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

    if (_feiLeiDataScourse == nil) {
        _feiLeiDataScourse = [NSMutableArray array];
        _feiLeiTuiJianarr = [NSMutableArray array];
        _iconArr = [NSMutableArray array];
        _iconScourse = [NSMutableArray array];
        _searchResultArr = [NSMutableArray array];
    }
    self.navigationController.navigationItem.title = @"分类";
    [self requestData];
    [self requestIconImage];
    [self creatView];
    
    
}

-(void)requestData{
    
    isFeiLeiFinish = NO;
    ASIHTTPRequest *feiLeiRequest = [ASIHTTPRequest requestWithURL:URLSTRING(FENLEIURL)];
    feiLeiRequest.tag = 10;
    feiLeiRequest.delegate = self;
    [feiLeiRequest startAsynchronous];
    
    while (!isFeiLeiFinish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    searchTotalData *totaldata = [searchTotalData shareSearchData];
    
    [totaldata.searchArr addObject:_feiLeiDataScourse];
    
}

-(void)requestIconImage{

    
    isIconFinish = NO;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置最大下载的个数
    queue.maxConcurrentOperationCount = 1;
    
    for (NSInteger i = 0; i < _feiLeiDataScourse.count; i++) {
        AIGOUIconModel *iconmodel = _feiLeiDataScourse[i];
        MyOperation *Noperation = [[MyOperation alloc] initWithUrl:iconmodel.normalicon];
        Noperation.tag = i;
        MyOperation *Soperation = [[MyOperation alloc] initWithUrl:iconmodel.selecticon];
        Soperation.tag = i + 100;
        Noperation.delegate = self;
        Soperation.delegate = self;
        //添加任务
        [queue addOperation:Noperation];
        [queue addOperation:Soperation];
    }
    
    while (!isIconFinish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

}

- (void)didFinishDownloadWithOpenation:(MyOperation *)operation downloadData:(NSData *)downlaodData{

    UIImage *iconimage = IMAGEDATA(downlaodData);
    [_iconArr addObject:iconimage];
    NSLog(@"%d",operation.tag);
    if (operation.tag == 100 + _feiLeiDataScourse.count - 1 ) {
        isIconFinish = YES;
    }
}



#pragma -mark ASIHTTPRequest请求数据结束

/*-----------------ASI代理方法接受请求数据-------------------------*/

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    if (request.tag == 10) {
        //分类数据解析
        NSDictionary *feiLeiDic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *listarr = feiLeiDic[@"result"][@"categories"];
        
        for (NSDictionary *listdic in listarr) {
            AIGOUIconModel *model = [[AIGOUIconModel alloc] init];
            model.normalicon = listdic[@"icon"];
            model.selecticon = listdic[@"selected"];
            model.title = listdic[@"title"];
            NSArray *listarr = listdic[@"list"];
            for (NSDictionary *listDic in listarr) {
                paymentlistmodel *listmodel = [[paymentlistmodel alloc]  init];
                listmodel.iconimgjpg = listDic[@"img"];
                listmodel.iconname = listDic[@"label"];
                listmodel.link = listDic[@"link"];
                [model.listarr addObject:listmodel];
            }
            [_feiLeiDataScourse addObject:model];
        }
        //推荐视图解析
        NSArray *recommentarr = feiLeiDic[@"result"][@"recommend"];
        for (NSDictionary *recommentdic in recommentarr) {
            paymentlistmodel *model = [[paymentlistmodel alloc] init];
            model.iconimgjpg = recommentdic[@"img"];
            model.link = recommentdic[@"link"];
            [_feiLeiTuiJianarr addObject:model];
        }
        isFeiLeiFinish = YES;
    }
}



- (void)requestFailed:(ASIHTTPRequest *)request{
    
    Alerk *alerk = [Alerk initWithmessage:@"网络连接失败"];
    [alerk show];
    
    NSLog(@"网络请求失败");
    
}
#pragma -mark 创建分类视图

#define MENVIEWW 80
#define SEARCHH 40

#define REUSECELL @"cell"

         /*---------创建分类视图-----------*/
-(void)creatView{
    
    
    //创建搜索栏
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, FRAMEW(self.view), SEARCHH)];
    searchbar.delegate = self;
    searchbar.backgroundImage = IMAGENAME(@"cart_shop_bg");
    searchbar.tag = 10;
    searchbar.layer.cornerRadius = 13.0f;
   // 自定义searchbar图片
    [searchbar setImage:IMAGENAME(@"cate_search_icon") forSearchBarIcon:UISearchBarIconSearch state:BTNNormal];
    searchbar.placeholder = @"百搭T恤,完美过夏天";
    searchbar.keyboardType = UIKeyboardTypeNamePhonePad;
    //Displaysearchbar搜索栏
    displaySearch = [[UISearchDisplayController alloc] initWithSearchBar:searchbar contentsController:self];
    
   // [displaySearch.searchResultsTableView registerNib:[UINib nibWithNibName:@"searchResultTableViewCell" bundle:nil] forCellReuseIdentifier:REUSECELL];

    displaySearch.searchResultsDelegate = self;
    displaySearch.searchResultsDataSource = self;
    displaySearch.delegate = self;
    displaySearch.searchBar.showsCancelButton = YES;
    
    
    
    //创建菜单栏
    FeiLeiMenuView *menuView = [[FeiLeiMenuView alloc] initWithFrame:CGRectMake(0, 30, MENVIEWW, FRAMEH(self.view) - 40 - 40)];
    menuView.delegate = self;
    NSInteger j = 0;
    for (NSInteger i = 0; i < _iconArr.count/2; i++) {
       // NSInteger k = i/2;
        AIGOUIconModel *agmodel = _feiLeiDataScourse[i];
        paymentlistmodel *model = [[paymentlistmodel alloc] init];
        model.iconnormalimage = _iconArr[j];
        model.iconselectimage = _iconArr[j+1];
        j = j + 2;
        model.iconname = agmodel.title;
        [_iconScourse addObject:model];
        
    }
    
    menuView.menuArr = _iconScourse;
    //创建详细列表
    detailview = [[feiLeiDetailScrollView alloc] initWithFrame:CGRectMake(FRAMEX(menuView) + FRAMEW(menuView) , FRAMEY(menuView), FRAMEW(self.view) - FRAMEW(menuView), FRAMEH(menuView))];
    detailview.isRecommend = YES;
    detailview.iconModel = _feiLeiDataScourse[0];
    detailview.recommendArr = [_feiLeiTuiJianarr copy];
 
    [self.view addSubview:menuView];
    [self.view addSubview:detailview];
    [self.view addSubview:searchbar];

    [displaySearch.searchResultsTableView reloadData];


}


#pragma -mark FeiLeiMenuView代理方法
/*-------------FeiLeiMenuView代理方法--------*/
-(void)FeiLeiMenuViewChange:(NSInteger)num{
    
    if (num == 0) {
        detailview.isRecommend = YES;
        detailview.iconModel = _feiLeiDataScourse[num];
        detailview.recommendArr = [_feiLeiTuiJianarr copy];
    }else{
        detailview.isRecommend = NO;
        detailview.iconModel = _feiLeiDataScourse[num];
    }
}

#pragma -mark searchDisplaytableView代理方法

/*-------------SearchBarTableView代理方法--------*/

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _searchResultArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSECELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSECELL];
    }
    
    cell.textLabel.text = _searchResultArr[indexPath.row];
    cell.backgroundColor = REDCLOR;
    return cell;
}

#pragma -mark searchDisplayController代理方法

/*----------searchDisplayController代理方法--------*/
//- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
//    NSLog(@"begin222");
//
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    //首先清空原来的旧数据
    if (_searchResultArr.count > 0)
    {
        [_searchResultArr removeAllObjects];
    }

    NSArray *arr = @[@"1",@"2",@"3",@"4",@"11",@"111"];
    //遍历数据源
    for (NSString *str in arr)
    {
        if ([str rangeOfString:searchText].location != NSNotFound)
            
        {
            //添加新的数据
            [_searchResultArr addObject:str];
        }
    }
    
    [displaySearch.searchResultsTableView reloadData];
}


- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{

    
    NSLog(@"begian");
}



//隐藏键盘

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
}




#pragma -mark 隐藏导航栏和状态栏

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarHidden =  YES;

}

#pragma -mark 显示导航栏和状态栏

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarHidden =  NO;

}



@end
