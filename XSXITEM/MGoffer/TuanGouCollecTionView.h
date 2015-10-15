//
//  TuanGouCollecTionView.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Common.h"
#import "Alerk.h"
#import "TouGouModel.h"
#import "TuanGouViewCell.h"
#import "TGCollectionViewlayout.h"
#import "TuanGouCollectionHeadView.h"



@interface TuanGouCollecTionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,ASIHTTPRequestDelegate,TGCollectionViewlayoutDelegate,UICollectionViewDelegateFlowLayout>

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;

@property(nonatomic ,strong) NSArray *datasourarr;

-(void)RuquestData;
@end
