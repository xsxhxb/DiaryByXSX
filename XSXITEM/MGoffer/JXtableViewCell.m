//
//  JXtableViewCell.m
//  MGoffer
//
//  Created by mac on 14-6-28.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "JXtableViewCell.h"

@implementation JXtableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setModel:(AGListCellModel *)model{

    if (_model != model) {
        _model = nil;
        _model = model;
        for (NSInteger i = 0; i < _model.tagtextarr.count; i++) {
            if (i == 0) {
                _imageletflaber.text = _model.tagtextarr[i];
            }else{
                _imagerightlaber.text = _model.tagtextarr[i];
            }
        }
        [_headimageview setImageWithURL:URLSTRING(_model.showimage)];
        _titlelaber.text = _model.title;
        _pricelaber.text = _model.price;
        _favlaber.text = [NSString stringWithFormat:@"%i",_model.cfavnum];
    }
    [self layoutSubviews];
}
//价格标签尺寸
#define PRITAGW 17
#define PRITAGH 15
//集赞标签尺寸
#define FAVTAGW 14
#define FAVTAGH 12
//价格尺寸
#define PRINUMTAGW 80
#define PRINUMTAGH 20
//集赞尺寸
#define FAVNUMTAGW 50
#define FAVNUMTAGH 20

#pragma -mark 重新布局CELLUI
-(void)layoutSubviews{
    
    _imageletflaber.font = [UIFont systemFontOfSize:15.0f];
    _imageletflaber.backgroundColor = PINCOLOR;
    _imagerightlaber.backgroundColor = PINCOLOR;
    _imageletflaber.textColor = WHITECOLOR;
    _imagerightlaber.textColor = WHITECOLOR;
    if (_model.tagtextarr.count == 0) {
        _imageletflaber.frame = CGRectZero;
        _imagerightlaber.frame = CGRectZero;
    }
    else if (_model.tagtextarr.count == 1){
        _imageletflaber.font = [UIFont systemFontOfSize:16.0f];
        NSString *str = [_model.tagtextarr lastObject];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(1000, 30)];
        _imageletflaber.frame = CGRectMake(10, 0, size.width, size.height);
        _imagerightlaber.frame = CGRectZero;
    }else {
        
        _imageletflaber.font = [UIFont systemFontOfSize:16.0f];
        NSString *str = [_model.tagtextarr firstObject];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(1000, 30)];
        _imageletflaber.frame = CGRectMake(10, 0, size.width, size.height);
        _imagerightlaber.font = [UIFont systemFontOfSize:16.0f];
        NSString *rightstr = [_model.tagtextarr lastObject];
        CGSize sizeright = [rightstr sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(1000, 30)];
        _imagerightlaber.frame = CGRectMake(FRAMEX(_imageletflaber) + FRAMEW(_imageletflaber) + 5, FRAMEY(_imageletflaber), sizeright.width, sizeright.height);
        
    
     }
         _headimageview.frame = CGRectMake(10, 0,150, 150);
    
        _titlelaber.font = [UIFont systemFontOfSize:14.0f];
        _titlelaber.numberOfLines = 3;
        CGSize sizetitle = [_model.title sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(FRAMEW(_headimageview), 1000)];
        _titlelaber.frame = CGRectMake(FRAMEX(_headimageview), FRAMEY(_headimageview)+FRAMEH(_headimageview), sizetitle.width, sizetitle.height);
    
    
        _Sepatorimageview.frame = CGRectMake(FRAMEX(_titlelaber), FRAMEY(_titlelaber)+FRAMEH(_titlelaber)+ 3, FRAMEW(_titlelaber), 1);
    
        _priceTagimageview.frame = CGRectMake(FRAMEX(_titlelaber), FRAMEY(_titlelaber) + FRAMEH(_titlelaber) + 8, PRITAGW, PRITAGH);
        
        _pricelaber.frame = CGRectMake(FRAMEX(_priceTagimageview)+FRAMEW(_priceTagimageview)+3, FRAMEY(_priceTagimageview)-4, PRINUMTAGW, PRINUMTAGH);
         _pricelaber.font = [UIFont systemFontOfSize:14.0f];
    
    
        _Favtagimgeview.frame = CGRectMake(FRAMEW(self) - FAVTAGW - FAVNUMTAGW , FRAMEY(_priceTagimageview) + 2 , FAVTAGW, FAVTAGH);
        
        _favlaber.frame = CGRectMake(FRAMEX(_Favtagimgeview)+FRAMEW(_Favtagimgeview)+5, FRAMEY(_pricelaber), FAVNUMTAGW, FAVNUMTAGH);
         _favlaber.font = [UIFont systemFontOfSize:14.0f];
  
}

@end
