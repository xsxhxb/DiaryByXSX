//
//  UICollectionViewlayout.m
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "TGCollectionViewlayout.h"

@interface TGCollectionViewlayout()
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, strong) NSMutableArray *itemAttributes; // attributes for each item
@end

@implementation TGCollectionViewlayout{

    //布局数据源，所有CELL都放这里
    NSMutableArray *attributiarr;
}


#pragma mark - Accessors
//set方法重写接受列数
- (void)setColumnCount:(NSUInteger)columnCount
{
    if (_columnCount != columnCount) {
        _columnCount = columnCount;
        [self invalidateLayout];
    }
}
//set方法重写设置CELL宽度
- (void)setItemWidth:(CGFloat)itemWidth
{
    if (_itemWidth != itemWidth) {
        _itemWidth = itemWidth;
        [self invalidateLayout];
    }
}
//set方法重写设置Sectio偏移量
//- (void)setSectionInset:(UIEdgeInsets)sectionInset
//{
//    if (!UIEdgeInsetsEqualToEdgeInsets(self.sectionInset, sectionInset)) {
//        self.sectionInset = sectionInset;
//        [self invalidateLayout];
//    }
//}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
        [self prepareLayout];
    }
    return self;
}

#pragma mark - Init
- (void)commonInit
{
    _columnCount = 2;
    _itemWidth = 150.0f;
    self.sectionInset = UIEdgeInsetsZero;
}

#pragma mark - Private Accessors
- (NSMutableDictionary *)headersAttribute {
    if (!_headersAttribute) {
        _headersAttribute = [NSMutableDictionary dictionary];
    }
    return _headersAttribute;
}



//当边界发生改变时，是否应该刷新布局

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return NO;
}

//数据源初始化
-(void)prepareLayout{
    
    [super prepareLayout];
    [self.headersAttribute removeAllObjects];

    _itemCount = [self.collectionView numberOfItemsInSection:0];
    NSLog(@"count = %i",_itemCount);
    
    NSAssert(_columnCount > 1, @"columnCount for UICollectionViewWaterfallLayout should be greater than 1.");
    //计算单元格宽度
    CGFloat width = self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right;
    //总空格大小 _columnCount列数
    _interitemSpacing = floorf((width - _columnCount * _itemWidth) / (_columnCount - 1));
    //单元格总数
    _itemAttributes = [NSMutableArray arrayWithCapacity:_itemCount];
    
    //列高_columnHeights
    _columnHeights = [NSMutableArray arrayWithCapacity:_columnCount];
  
    UICollectionViewLayoutAttributes *attributes;
    attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    attributes.frame = CGRectMake(0, 0 , self.collectionView.frame.size.width, 100);
    
    self.headersAttribute[@(0)] = attributes;
    [_itemAttributes addObject:attributes];
    
    self.sectionInset = UIEdgeInsetsMake(self.headerReferenceSize.height, 9, 0, 9);
    
    
    for (NSInteger idx = 0; idx < _columnCount; idx++) {
        [_columnHeights addObject:@(self.sectionInset.top)];
    }
    
    // Item will be put into shortest column.
    //单元格总数_itemCount
    //CELL布局实现
    for (NSInteger idx = 0; idx < _itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        //布局代理方法
        CGFloat itemHeight = [self.layoutdelegate collectionView:self.collectionView
                                                    layout:self
                                  heightForItemAtIndexPath:indexPath];
        
        NSUInteger columnIndex = [self shortestColumnIndex];
        //X偏移量
        CGFloat xOffset = self.sectionInset.left + (_itemWidth + _interitemSpacing) * columnIndex;
        //Y偏移量
        CGFloat yOffset = [(_columnHeights[columnIndex]) floatValue];
        //取出原来CELL的布局属性
        UICollectionViewLayoutAttributes *attributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //设置CELL新的FRAME
        attributes.frame = CGRectMake(xOffset, yOffset, self.itemWidth, itemHeight);
        //把实现好布局的CELL添加到CELL的数据源
        [_itemAttributes addObject:attributes];
        _columnHeights[columnIndex] = @(yOffset + itemHeight + _interitemSpacing);
    }
    [self invalidateLayout];
    
    
}

#pragma -mark设置collectionView的ContentSize
- (CGSize)collectionViewContentSize
{
    if (self.itemCount == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.frame.size;
    //最长尺寸单元格设置高度
    NSUInteger columnIndex = [self longestColumnIndex];
    CGFloat height = [self.columnHeights[columnIndex] floatValue];
    //计算高度
    contentSize.height = height - self.interitemSpacing + self.sectionInset.bottom;
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = nil;
    
    attribute = self.headersAttribute[@(0)];
    
    return attribute;
}


//最重要的代理方法返回CELL的布局FRAME
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    return (self.itemAttributes)[path.item];
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        //单元格尺寸相交
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}


#pragma mark - Private Methods
//最短的CELL下标
// Find out shortest column.
- (NSUInteger)shortestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;
    
    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}
//最高的CELL下标
// Find out longest column.
- (NSUInteger)longestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}

@end
