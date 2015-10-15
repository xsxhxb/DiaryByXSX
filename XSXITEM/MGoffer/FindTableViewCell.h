//
//  FindTableViewCell.h
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewModel.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@interface FindTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *UPimageview;
@property (weak, nonatomic) IBOutlet UIImageView *BigDownimageview;
@property (weak, nonatomic) IBOutlet UIImageView *SmallDownImageview;
@property (weak, nonatomic) IBOutlet UIImageView *SmallDownImageview2;
@property (nonatomic ,strong) FindViewModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconimagview;
@property (weak, nonatomic) IBOutlet UILabel *titleLaber;

-(void)setModel:(FindViewModel *)model;
 

@end
