//
//  BDTableViewCell.m
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "BDTableViewCell.h"

@implementation BDTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}
#pragma -mark 接受数据
-(void)setModel:(BDmodel *)model{
   // 大小可变图片
 //   http://s13.mogujie.cn/b7/pic/140617/11xgrd_kq2ecucwkrbgossugfjeg5sckzsew_450x600.jpg_210x264.jpg
    if (_model != model) {
        _model = nil;
        _model = model;
        NSLog(@"is top = %i",_isTopRow);
        for (NSInteger i = 0 ; i < _model.Listarr.count; i ++) {
            AGListCellModel *model = _model.Listarr[i];
            
            NSMutableString *imagurl = [NSMutableString stringWithString:model.showimage];
            NSRange range = [imagurl rangeOfString:@"jpg"];
            NSString *strplace = [imagurl substringFromIndex:range.length + range.location];
            
            NSRange replace = range;
            replace.location = range.location + range.length;
            replace.length = strplace.length;
            [imagurl replaceCharactersInRange:replace withString:@""];
          //  NSLog(@"imageurl = %@",imagurl);
            
            if (i == 0) {
                [_BGfirstimageview setImageWithURL:URLSTRING(imagurl)];
                _PriceLaber.text = model.price;
                _Favlaber.text = [NSString stringWithFormat:@"%i",model.cfavnum];
            }else if (i == 1){
                [_BGsecondimageview setImageWithURL:URLSTRING(imagurl)];
                _SecondPricelaber.text = model.price;
                _SecondFavlaber.text = [NSString stringWithFormat:@"%i",model.cfavnum];
            }else{
                [_BGThreeimageview setImageWithURL:URLSTRING(imagurl)];
                _ThreePricelaber.text = model.price;
                _ThreeFavlaber.text = [NSString stringWithFormat:@"%i",model.cfavnum];
            }
        }
    }
    [self layoutSubviews];
}
#pragma -mark 视图布局

#define TOPW 26
#define TOPH 26

-(void)layoutSubviews{
   // NSLog(@"istoprow = %i",_isTopRow);
    if (_isTopRow == NO) {
        _firstimageivewTopImage.frame = CGRectZero;
        _Secondimageviewtopimage.frame = CGRectZero;
        _Threeimageviewtopimage.frame = CGRectZero;
    }else{
        _firstimageivewTopImage.frame = CGRectMake(FRAMEX(_BGfirstimageview), FRAMEY(_BGfirstimageview), TOPW, TOPH);
        _Secondimageviewtopimage.frame =  CGRectMake(FRAMEX(_BGsecondimageview), FRAMEY(_BGsecondimageview), TOPW, TOPH);
        _Threeimageviewtopimage.frame =  CGRectMake(FRAMEX(_BGThreeimageview), FRAMEY(_BGThreeimageview), TOPW, TOPH);
    }
    _PriceLaber.font = FONT(12.5f);
    _Favlaber.font = FONT(12.5f);
    _Favlaber.textAlignment = NSTextAlignmentCenter;
    _SecondFavlaber.font = FONT(12.5f);
    _SecondFavlaber.textAlignment = NSTextAlignmentCenter;
    _SecondPricelaber.font = FONT(12.5f);
    _ThreePricelaber.font = FONT(12.5f);
    _ThreeFavlaber.textAlignment = NSTextAlignmentCenter;
    _ThreeFavlaber.font = FONT(12.5f);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
