//
//  JXtableViewCell.h
//  MGoffer
//
//  Created by mac on 14-6-28.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGListCellModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface JXtableViewCell : UITableViewCell

@property(nonatomic ,strong) AGListCellModel *model;
@property (weak, nonatomic) IBOutlet UILabel *imageletflaber;
@property (weak, nonatomic) IBOutlet UILabel *imagerightlaber;
@property (weak, nonatomic) IBOutlet UIImageView *headimageview;
@property (weak, nonatomic) IBOutlet UILabel *titlelaber;
@property (weak, nonatomic) IBOutlet UILabel *pricelaber;
@property (weak, nonatomic) IBOutlet UILabel *favlaber;
@property (weak, nonatomic) IBOutlet UIImageView *priceTagimageview;
@property (weak, nonatomic) IBOutlet UIImageView *Favtagimgeview;
@property (weak, nonatomic) IBOutlet UIImageView *Sepatorimageview;

@end
