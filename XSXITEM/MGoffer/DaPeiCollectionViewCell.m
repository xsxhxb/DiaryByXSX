//
//  DaPeiCollectionViewCell.m
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "DaPeiCollectionViewCell.h"

@implementation DaPeiCollectionViewCell{

     BOOL tagexit;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*-----------数据加载-----------*/
-(void)setModel:(AGListCellModel *)model{
    
    if (_model != model) {
        _model = nil;
        _model = model;

        NSLog(@"model first");
        NSMutableString *imagestr = [NSMutableString stringWithString:_model.showimage];
        
        if ([_model.showimage rangeOfString:@"_320x999.webp"].location != NSNotFound) {
            
            NSRange imagerange = [_model.showimage rangeOfString:@"_320x999.webp"];

            [imagestr replaceCharactersInRange:imagerange withString:@""];
        }
        
        [_headImageView setImageWithURL:URLSTRING(imagestr)];
        [_personImageView setImageWithURL:URLSTRING(_model.avatar)];
        if (_model.tagtextarr.count != 0) {
            tagexit = YES;
            _tagLaber.text = [_model.tagtextarr lastObject];
        }else{
            tagexit = NO;
        }
        _personNameLaber.text = _model.uname;
        _shopDetailLaber.text = _model.title;
        
        _CDLaber.text = [NSString stringWithFormat:@"%i件穿搭",_model.cphotonum];
        
        _favLaber.text = [NSString stringWithFormat:@"%i",_model.cfavnum];
    }
    self.backgroundColor = WHITECOLOR;
    [self setNeedsLayout];
}

/*--------------视图重新布局-------------*/

#define HEADIMAGEH 160
#define HEADLABERW 60
#define HEADLABERH 22
#define PERSONH 64
#define PERSONLABERW 100
#define ICONW 13

#define ICONLABERW 100


-(void)layoutSubviews{
    
    [super layoutSubviews];
//    if (_model.tagtextarr.count != 0) {
//        tagexit = YES;
//    }else{
//        tagexit = NO;
//    }
    NSLog(@"layout second");
    _headImageView.frame = CGRectMake(5, 0, FRAMEW(self) - 10, HEADIMAGEH );
    //没有显示则隐藏
    if ([_tagLaber.text isEqualToString:@""]) {
        _tagLaber.frame = CGRectZero;
        _tagLaber.textColor = CCCLOR;
        
    }else{
        _tagLaber.frame = CGRectMake(FRAMEX(_headImageView), FRAMEY(_headImageView), HEADLABERW, HEADLABERH);
        _tagLaber.textAlignment = NSTextAlignmentCenter;
        _tagLaber.backgroundColor = REDCLOR;
        _tagLaber.textColor = WHITECOLOR;
        _tagLaber.font = FONT(13.0f);
    }
        _personImageView.frame = CGRectMake(FRAMEX(_headImageView)+10, FRAMEY(_headImageView)+FRAMEH(_headImageView)- PERSONH/6, PERSONH/2, PERSONH/2);
        
        _personImageView.layer.cornerRadius = 15.0f;
        
        _personImageView.clipsToBounds = YES;
    
        _personImageView.contentMode = UIViewContentModeScaleAspectFit;
        _personNameLaber.frame = CGRectMake(FRAMEX(_personImageView) + FRAMEW(_personImageView), FRAMEY(_personImageView) + 10, PERSONLABERW ,HEADLABERH );
    
        _personNameLaber.font = FONT(11.0f);
        _personNameLaber.textAlignment = NSTextAlignmentCenter;

        _shopDetailLaber.font = FONT(13.0f);
        _shopDetailLaber.textAlignment = NSTextAlignmentLeft;
        CGFloat height = _model.titlesize.height;
        if (height > 50.0f) {
        _shopDetailLaber.numberOfLines = 3;
            height = 50.0f;
        }else{
        _shopDetailLaber.numberOfLines = 0;
        }
    
        _shopDetailLaber.frame = CGRectMake(FRAMEX(_personImageView), FRAMEY(_personImageView)+FRAMEH(_personImageView) , _model.titlesize.width , height);
        _sepatorImageview.frame = CGRectMake(FRAMEX(_shopDetailLaber), FRAMEY(_shopDetailLaber)+FRAMEH(_shopDetailLaber)+1, FRAMEW(_shopDetailLaber), 2);
        //穿衣指数
        _CDImageView.frame = CGRectMake(FRAMEX(_sepatorImageview), FRAMEY(_sepatorImageview) + 5, ICONW, ICONW);
        
        _CDLaber.frame = CGRectMake(FRAMEX(_CDImageView) + FRAMEW(_CDImageView), FRAMEY(_CDImageView), ICONLABERW, ICONW + 5);
        _CDLaber.textAlignment = NSTextAlignmentLeft;
        _CDLaber.textColor = REDCLOR;
        _CDLaber.font = FONT(13.0f);
        
        _favImageView.frame = CGRectMake(FRAMEW(self) - ICONW * 2 - ICONW * 2, FRAMEY(_CDImageView), ICONW , ICONW);
        
        
        _favLaber.frame = CGRectMake(FRAMEX(_favImageView) + FRAMEW(_favImageView), FRAMEY(_favImageView), ICONW * 2 + 10, ICONW + 5);
        _favLaber.font = FONT(12.0f);
        _favLaber.textAlignment = NSTextAlignmentLeft;
}

@end
