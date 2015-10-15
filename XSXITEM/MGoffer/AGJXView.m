//
//  AGJXView.m
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "AGJXView.h"

@implementation AGJXView{

    NSMutableArray *_cellHeights;
    AiGouModel *_model;
    //collectionView总高度
    CGFloat _totalHeight;
    BOOL isRowFirst;
}

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;

{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self CreatView];
    }
    return self;
}
#define REUSEABLE_CELL_IDENTITY @"cell"
#define REUSEABLE_HEAD_IDENTITY @"cell2"

-(void)reloadDatascorse{
    
    self.backgroundColor = WHITECOLOR;
    self.delegate = self;

    self.dataSource = self;
    self.scrollEnabled = YES;
    _model = _receiveModel;
    [self reloadData];
    
}




#pragma -mark 创建CollecView视图
-(void)CreatView{
    
    
    [self registerNib:[UINib nibWithNibName:@"AGJXCell" bundle:nil] forCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY];
    
    [self registerClass:[AGJXHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:REUSEABLE_HEAD_IDENTITY];
    
}





#pragma -mark 所有CELl的高度数组
//总的CELl的高度数组
- (NSMutableArray *)cellHeights
{
   // TouGouModel *model = [datasourarr lastObject];
    //懒加载
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:_model.Listarr.count];
        for (NSInteger i = 0; i <_model.Listarr.count; i++) {
            if (i == 0) {
                AGListCellModel *model = _model.Listarr[i];
                _cellHeights[i] = [NSString stringWithFormat:@"%i",model.showH];
            }else{
            AGListCellModel *model = _model.Listarr[i];
            NSInteger m =  200;
            _cellHeights[i] = [NSString stringWithFormat:@"%f",m + model.titlesize.height ];
            }
        }
    }else{
    
        [_cellHeights removeAllObjects];
        for (NSInteger i = 0; i <_model.Listarr.count; i++) {
            if (i == 0) {
                AGListCellModel *model = _model.Listarr[i];
                _cellHeights[i] = [NSString stringWithFormat:@"%i",model.showH];
            }else{
                AGListCellModel *model = _model.Listarr[i];
                NSInteger m =  200;
                _cellHeights[i] = [NSString stringWithFormat:@"%f",m + model.titlesize.height ];
            }
        }
    }
    
    _totalHeight = 0;
    
    for (NSString *heightStr in _cellHeights) {
        CGFloat cellheiht = [heightStr floatValue];
        _totalHeight += cellheiht;
    }
    
    return _cellHeights;
}

#pragma -mark Items数量

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _model.Listarr.count;
    
}

#pragma -mark Sections数量

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AGJXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        isRowFirst = YES;
        
    }else{
        isRowFirst = NO;
    }
    AGListCellModel *cellmodel = _model.Listarr[indexPath.row];
    cell.isFirst = isRowFirst;
    cell.model = cellmodel;
    return cell;
}



#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(TGCollectionViewlayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath

{
    CGFloat h = [self.cellHeights[indexPath.item] floatValue];
    return h;
}




-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    AGJXHeadView *headview;

    headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:REUSEABLE_HEAD_IDENTITY forIndexPath:indexPath];
    headview.modelarr = [_model.headimageurl copy];
    return headview;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(320, 100);
    
}

#pragma -mark 下拉刷新判断滑动底部

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//
//}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (scrollView == self) {
        NSLog(@"totalheight = %f",_totalHeight/2 - 200);
        NSLog(@"collectionheiht = %f",scrollView.contentOffset.y);
    }
    
    
    if (self.contentOffset.y > _totalHeight/2 -200 ) {
        if (_AGJXdelegate && [_AGJXdelegate respondsToSelector:@selector(reFreshCollectionView:)]) {
            [_AGJXdelegate reFreshCollectionView:1];
        }
    }
    
    
}

@end
