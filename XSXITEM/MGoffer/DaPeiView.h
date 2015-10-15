//
//  DaPeiView.h
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaPeiCollectionViewCell.h"
#import "Common.h"
#import "TGCollectionViewlayout.h"


@interface DaPeiView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,TGCollectionViewlayoutDelegate>

@property(nonatomic ,strong) NSArray *datasourarr;

-(void)reloadDataScourse;


@end
