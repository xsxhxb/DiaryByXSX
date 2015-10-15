//
//  AGJXCell.h
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGListCellModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface AGJXCell : UICollectionViewCell


@property(nonatomic ,strong) AGListCellModel *model;

@property (weak, nonatomic) IBOutlet UILabel *imageLetfLaber;
@property (weak, nonatomic) IBOutlet UILabel *imageRightLaber;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLaber;
@property (weak, nonatomic) IBOutlet UIImageView *sepatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *priceTagImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLaber;
@property (weak, nonatomic) IBOutlet UIImageView *favTagImageView;
@property (weak, nonatomic) IBOutlet UILabel *favTagLaber;

@property(nonatomic ,assign) BOOL isFirst;

@end
