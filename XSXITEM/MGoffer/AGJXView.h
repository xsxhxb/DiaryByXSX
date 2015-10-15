//
//  AGJXView.h
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGJXHeadView.h"
#import "AGJXCell.h"
#import "TGCollectionViewlayout.h"
#import "AiGouModel.h"
#import "AGListCellModel.h"


@protocol AGJXViewdelegate <NSObject>

-(void)reFreshCollectionView:(NSInteger)page;

@end


@interface AGJXView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,TGCollectionViewlayoutDelegate,UIScrollViewDelegate>

@property(nonatomic ,strong) AiGouModel *receiveModel;
@property(nonatomic ,weak) id<AGJXViewdelegate> AGJXdelegate;
-(void)reloadDatascorse;

@end
