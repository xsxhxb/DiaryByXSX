//
//  FindTableViewCell.m
//  MGoffer
//
//  Created by mac on 14-6-29.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "FindTableViewCell.h"

@implementation FindTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}
-(void)setModel:(FindViewModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
        //判断小图是否加载完成
        BOOL isfirstimage;
        isfirstimage = YES;
        //加载CELL四张大图
        for (SuperModel *supermodel in _model.imagearr) {
            NSLog(@"showimage = %@",supermodel.showimage);
            if ([supermodel.showimage rangeOfString:@"370x256"].location != NSNotFound) {
                [_BigDownimageview setImageWithURL:URLSTRING(supermodel.showimage)];
            }
            else if ([supermodel.showimage rangeOfString:@"184x256"].location != NSNotFound){
                if (isfirstimage == YES) {
                    [_SmallDownImageview setImageWithURL:URLSTRING(supermodel.showimage)];
                    isfirstimage = NO;
                }else{
                    [_SmallDownImageview2 setImageWithURL:URLSTRING(supermodel.showimage)];
                }
            }
            else if ([supermodel.showimage rangeOfString:@"240x514"].location != NSNotFound || [supermodel.showimage rangeOfString:@"230x514"].location != NSNotFound ) {
                [_UPimageview setImageWithURL:URLSTRING(supermodel.showimage)];
            }
        }
        [_iconimagview setImageWithURL:URLSTRING(_model.title_iconurl)];
        _titleLaber.text = _model.title_text;
        
    }
    [self layoutSubviews];
}

#pragma -mark 视图重新布局

#define iconimagW 50
#define iconLaberW 120
#define iconLaberH 40
#define IMAGEW 100
#define IMAGEH 120


-(void)layoutSubviews{
    
     _iconimagview.frame = CGRectMake(10, 5, iconimagW/2, iconimagW/2);
     _titleLaber.frame = CGRectMake(FRAMEX(_iconimagview) + FRAMEH(_iconimagview) + 2, FRAMEY(_iconimagview) - 6, iconLaberW, iconLaberH);
     _titleLaber.font = [UIFont systemFontOfSize:14.0f];
    NSLog(@"type = %@",_model.item_type);
    if ([_model.item_type isEqualToString:@"1"]) {
        //横的大视图
        _BigDownimageview.frame = CGRectMake(FRAMEX(_iconimagview), FRAMEY(_iconimagview) + FRAMEH(_iconimagview) , IMAGEW * 2 - 2, IMAGEH);
        _SmallDownImageview.frame = CGRectMake(FRAMEX(_BigDownimageview), FRAMEY(_BigDownimageview) + FRAMEH(_BigDownimageview)+2, IMAGEW-2, IMAGEH-2);
        _SmallDownImageview2.frame = CGRectMake(FRAMEX(_SmallDownImageview) + FRAMEW(_SmallDownImageview) + 2, FRAMEY(_SmallDownImageview), IMAGEW-2, IMAGEH-2);
        _UPimageview.frame = CGRectMake(FRAMEX(_BigDownimageview) + FRAMEW(_BigDownimageview) + 2, FRAMEY(_BigDownimageview), IMAGEW, IMAGEH * 2);
        
    }else{
        
        _UPimageview.frame = CGRectMake(FRAMEX(_iconimagview),FRAMEY(_iconimagview) + FRAMEH(_iconimagview), IMAGEW , IMAGEH * 2);
        //横的大视图
        _BigDownimageview.frame = CGRectMake(FRAMEX(_UPimageview) + FRAMEW(_UPimageview) + 2 , FRAMEY(_UPimageview) , IMAGEW * 2 - 2, IMAGEH);
        _SmallDownImageview.frame = CGRectMake(FRAMEX(_BigDownimageview), FRAMEY(_BigDownimageview) + FRAMEH(_BigDownimageview)+2, IMAGEW - 2, IMAGEH-2);
        _SmallDownImageview2.frame = CGRectMake(FRAMEX(_SmallDownImageview) + FRAMEW(_SmallDownImageview), FRAMEY(_SmallDownImageview), IMAGEW-2, IMAGEH-2);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
