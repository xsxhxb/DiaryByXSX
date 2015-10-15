//
//  UICollectionViewlayout.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuanGouCollectionHeadView.h"

@class TGCollectionViewlayout;
@protocol TGCollectionViewlayoutDelegate <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(TGCollectionViewlayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface TGCollectionViewlayout : UICollectionViewFlowLayout<UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<TGCollectionViewlayoutDelegate> layoutdelegate;
@property (nonatomic, assign) NSUInteger columnCount; // How many columns
@property (nonatomic, assign) CGFloat itemWidth; // Width for every column
//@property (nonatomic, assign) UIEdgeInsets sectionInset; // The margins used to lay out content in a section
@property (nonatomic, strong) NSMutableDictionary *headersAttribute;
@property (nonatomic, strong) NSMutableArray *columnHeights;

-(id)init;

@end
