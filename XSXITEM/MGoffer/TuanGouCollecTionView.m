//
//  TuanGouCollecTionView.m
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "TuanGouCollecTionView.h"

@implementation TuanGouCollecTionView{
    
    NSMutableArray *_cellHeights;
}

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;

{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self CreatView];
       // [self RuquestData];
    }
    return self;
}
#define REUSEABLE_CELL_IDENTITY @"cell"
#define REUSEABLE_HEAD_IDENTITY @"cell2"

-(void)RuquestData{
    
    [self reloadData];

}


#pragma -mark 创建CollecView视图
-(void)CreatView{
    
    [self registerNib:[UINib nibWithNibName:@"TuanGouViewCell" bundle:nil] forCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY];
    
    [self registerClass:[TuanGouCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:REUSEABLE_HEAD_IDENTITY];
    
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = WHITECOLOR;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}



#pragma -mark 所有CELl的高度数组
//总的CELl的高度数组
- (NSMutableArray *)cellHeights
{
    TouGouModel *model = [_datasourarr lastObject];
    //懒加载
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:model.listarr.count];
        for (NSInteger i = 0; i < model.listarr.count; i++) {
            NSInteger m =  220;
            _cellHeights[i] = [NSString stringWithFormat:@"%i",m];
        }
    }
    return _cellHeights;
}

#pragma -mark Items数量

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    TouGouModel *tuangoumodel = [_datasourarr lastObject];
    return tuangoumodel.listarr.count;

}

#pragma -mark Sections数量

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TuanGouViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY forIndexPath:indexPath];
    
    TouGouModel *tuangoumodel = [_datasourarr lastObject];
    TouGouModel *model = tuangoumodel.listarr[indexPath.row];
    cell.model = model;
  
    return cell;
}



#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(TGCollectionViewlayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath

{
  
    CGFloat h = [self.cellHeights[indexPath.item] floatValue];
    NSLog(@"height = %f",h);
    return h;
}




-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    TuanGouCollectionHeadView *headview;
    
    headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:REUSEABLE_HEAD_IDENTITY forIndexPath:indexPath];
    TouGouModel *model = [_datasourarr lastObject];
    headview.modelarr = model.HeadViewarr;
    return headview;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(320, 100);
    
}

#if 0

#pragma -mark ASI数据请求代理
/*-------------- ASI数据请求代理 ------------ */

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSDictionary *TuanGouDic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
    TouGouModel *tuanGoumodel = [[TouGouModel alloc] init];
    NSArray *catearr = TuanGouDic[@"result"][@"cate"];
    
    for (NSDictionary *catedic in catearr) {
        //接受弹出菜单视图
        SuperModel *catemodel = [[SuperModel alloc] init];
        catemodel.showimage = catedic[@"image"];
        catemodel.title = catedic[@"value"];
        [menuarr addObject:catemodel];
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
    
    [datasourarr addObject:tuanGoumodel];
    [self reloadData];
}

#endif


@end
