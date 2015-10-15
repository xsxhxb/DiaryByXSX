
//
//  AGJXCell.m
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "AGJXCell.h"

@implementation AGJXCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setModel:(AGListCellModel *)model{
    
    if (_model != model) {
        _model = nil;
        _model = model;
        if (_isFirst == YES) {
        [_headImageView setImageWithURL:URLSTRING(_model.showimage)];

        }else{
        
        for (NSInteger i = 0; i < _model.tagtextarr.count; i++) {
            if (i == 0) {
                _imageLetfLaber.text = _model.tagtextarr[i];
            }else{
                _imageRightLaber.text = _model.tagtextarr[i];
            }
        }
        [_headImageView setImageWithURL:URLSTRING(_model.showimage)];
        _titleLaber.text = _model.title;
        _priceLaber.text = _model.price;
        _favTagLaber.text = [NSString stringWithFormat:@"%i",_model.cfavnum];
      }
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
    
    if (_isFirst == YES) {
        _headImageView.frame = CGRectMake(10, 0,_model.showW, _model.showH);
        _imageLetfLaber.frame = CGRectZero;
        _imageRightLaber.frame = CGRectZero;
        _titleLaber.frame = CGRectZero;
        _sepatorImageView.frame = CGRectZero;
        _favTagImageView.frame = CGRectZero;
        _favTagLaber.frame = CGRectZero;
        _priceLaber.frame = CGRectZero;
        _priceTagImageView.frame = CGRectZero;
    }else{
        
    _imageLetfLaber.font = [UIFont systemFontOfSize:15.0f];
    _imageLetfLaber.backgroundColor = PINCOLOR;
    _imageLetfLaber.textColor = WHITECOLOR;
    _imageRightLaber.textColor = WHITECOLOR;
    _imageRightLaber.backgroundColor = PINCOLOR;

    if (_model.tagtextarr.count == 0) {
        _imageLetfLaber.frame = CGRectZero;
        _imageRightLaber.frame = CGRectZero;
    }
    else if (_model.tagtextarr.count == 1){
        _imageLetfLaber.font = [UIFont systemFontOfSize:16.0f];
        NSString *str = [_model.tagtextarr lastObject];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(1000, 30)];
        _imageLetfLaber.frame = CGRectMake(10, 0, size.width, size.height);
        _imageRightLaber.frame = CGRectZero;
    }else {
        
        _imageLetfLaber.font = [UIFont systemFontOfSize:16.0f];
        NSString *str = [_model.tagtextarr firstObject];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(1000, 30)];
        _imageLetfLaber.frame = CGRectMake(10, 0, size.width, size.height);
        _imageRightLaber.font = [UIFont systemFontOfSize:16.0f];
        NSString *rightstr = [_model.tagtextarr lastObject];
        CGSize sizeright = [rightstr sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(1000, 30)];
        _imageRightLaber.frame = CGRectMake(FRAMEX(_imageLetfLaber) + FRAMEW(_imageLetfLaber) + 5, FRAMEY(_imageLetfLaber), sizeright.width, sizeright.height);
    }
    _headImageView.frame = CGRectMake(10, 0,145, 160);
    
    _titleLaber.font = [UIFont systemFontOfSize:13.0f];
    _titleLaber.numberOfLines = 0;
    _titleLaber.frame = CGRectMake(FRAMEX(_headImageView), FRAMEY(_headImageView)+FRAMEH(_headImageView), _model.titlesize.width, _model.titlesize.height);
    
    
    _sepatorImageView.frame = CGRectMake(FRAMEX(_titleLaber), FRAMEY(_titleLaber)+FRAMEH(_titleLaber)+ 3, FRAMEW(_titleLaber), 1);
    
    _priceTagImageView.frame = CGRectMake(FRAMEX(_titleLaber), FRAMEY(_titleLaber) + FRAMEH(_titleLaber) + 8, PRITAGW, PRITAGH);
    
    _priceLaber.frame = CGRectMake(FRAMEX(_priceTagImageView)+FRAMEW(_priceTagImageView)+3, FRAMEY(_priceTagImageView)-4, PRINUMTAGW, PRINUMTAGH);
    _priceLaber.font = [UIFont systemFontOfSize:14.0f];
    
    
    _favTagImageView.frame = CGRectMake(FRAMEW(self) - FAVTAGW - FAVNUMTAGW , FRAMEY(_priceTagImageView) + 2 , FAVTAGW, FAVTAGH);
    
    _favTagLaber.frame = CGRectMake(FRAMEX(_favTagImageView)+FRAMEW(_favTagImageView)+5, FRAMEY(_priceLaber), FAVNUMTAGW, FAVNUMTAGH);
    _favTagLaber.font = [UIFont systemFontOfSize:14.0f];
    }
    
}

@end
