//
//  DaPeiView.m
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "DaPeiView.h"

@implementation DaPeiView{

    NSMutableArray *_cellHeights;
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

-(void)reloadDataScourse{
    
    [self reloadData];
    
}


#pragma -mark 创建CollecView视图
-(void)CreatView{
    
    [self registerNib:[UINib nibWithNibName:@"DaPeiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY];
    
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
    //懒加载
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:_datasourarr.count];
        for (NSInteger i = 0; i < _datasourarr.count; i++) {
            NSInteger m =  220;
            AGListCellModel *model = _datasourarr[i];
            NSInteger height = m + model.titlesize.height;
            if(height > 260){
                height = 260;
            }
            _cellHeights[i] = [NSString stringWithFormat:@"%i",height];
            
            NSLog(@"height = %@",_cellHeights[i]);
        }
    }
    
    return _cellHeights;
}

#pragma -mark Items数量

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datasourarr.count;
    
}

#pragma -mark Sections数量

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DaPeiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY forIndexPath:indexPath];
    
    AGListCellModel *model = _datasourarr[indexPath.row];

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


@end
