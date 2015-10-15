//
//  TuanGouViewCell.h
//  MGoffer
//
//  Created by mac on 14-6-30.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouGouModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"



@interface TuanGouViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *Titlelaber;


@property (weak, nonatomic) IBOutlet UILabel *NowPricelaber;

@property (weak, nonatomic) IBOutlet UILabel *OldPricelLaber;
@property (weak, nonatomic) IBOutlet UILabel *SaleLaber;

@property (weak, nonatomic) IBOutlet UILabel *TimeLaber;
@property (weak, nonatomic) IBOutlet UILabel *PersonTotallaber;

@property (weak, nonatomic) IBOutlet UIImageView *SepLineimageview;

@property (weak, nonatomic) IBOutlet UIImageView *Timeimageview;
@property (weak, nonatomic) IBOutlet UIImageView *Personimageview;


@property(nonatomic ,strong) TouGouModel *model;

-(void)setModel:(TouGouModel *)model;

@end
