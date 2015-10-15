//
//  DaPeiCollectionViewCell.h
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGListCellModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface DaPeiCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *tagLaber;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLaber;
@property (weak, nonatomic) IBOutlet UILabel *shopDetailLaber;
@property (weak, nonatomic) IBOutlet UIImageView *sepatorImageview;
@property (weak, nonatomic) IBOutlet UIImageView *CDImageView;
@property (weak, nonatomic) IBOutlet UILabel *CDLaber;
@property (weak, nonatomic) IBOutlet UIImageView *favImageView;
@property (weak, nonatomic) IBOutlet UILabel *favLaber;

@property(nonatomic ,strong) AGListCellModel *model;

@end
