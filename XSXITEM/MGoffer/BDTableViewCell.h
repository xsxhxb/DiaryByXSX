//
//  BDTableViewCell.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGListCellModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "BDmodel.h"

@interface BDTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BGfirstimageview;
@property (weak, nonatomic) IBOutlet UIImageView *BGsecondimageview;
@property (weak, nonatomic) IBOutlet UIImageView *BGThreeimageview;
@property (weak, nonatomic) IBOutlet UIImageView *firstimageivewTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *Secondimageviewtopimage;
@property (weak, nonatomic) IBOutlet UIImageView *Threeimageviewtopimage;
@property (weak, nonatomic) IBOutlet UILabel *PriceLaber;
@property (weak, nonatomic) IBOutlet UILabel *Favlaber;
@property (weak, nonatomic) IBOutlet UILabel *SecondPricelaber;
@property (weak, nonatomic) IBOutlet UILabel *SecondFavlaber;

@property (weak, nonatomic) IBOutlet UILabel *ThreePricelaber;
@property (weak, nonatomic) IBOutlet UILabel *ThreeFavlaber;

@property (nonatomic ,assign) BOOL isTopRow;

@property(nonatomic ,strong) BDmodel *model;

-(void)setModel:(BDmodel *)model;

@end
