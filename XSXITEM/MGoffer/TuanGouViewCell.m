//
//  TuanGouViewCell.m
//  MGoffer
//
//  Created by mac on 14-6-30.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "TuanGouViewCell.h"

@implementation TuanGouViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

#pragma -mark  写入数据
-(void)setModel:(TouGouModel *)model{
    
    if (_model != model) {
        
        NSLog(@"tuangou model first");
        _model = nil;
        _model = model;
        [_HeadImageView setImageWithURL:URLSTRING(_model.showimage)];
        _Titlelaber.text = _model.title;
        _NowPricelaber.text =[NSString stringWithFormat:@"￥%@", _model.price];
        _OldPricelLaber.text = [NSString stringWithFormat:@"￥%@",_model.oldPrice];
        _SaleLaber.text = [NSString stringWithFormat:@"%@折",_model.discount];
        _TimeLaber.text = @"0天15小时03分";
        _PersonTotallaber.text = [NSString stringWithFormat:@"%i",_model.boughtTotal];
    }
    [self layoutSubviews];
}


#pragma -mark  重新布局
#define OLDW 50
#define OLDH 20
#define TIMAGE 10
#define BIGLABEH 30

-(void)layoutSubviews{
    
    NSLog(@"tuangou layout second");
    
    _HeadImageView.frame = CGRectMake(10, 0, 145, 145);
  //  _HeadImageView.backgroundColor = [UIColor blueColor];
    
    _Titlelaber.frame = CGRectMake(FRAMEX(_HeadImageView), FRAMEY(_HeadImageView)+ FRAMEH(_HeadImageView), FRAMEW(self), BIGLABEH - 5);
    _Titlelaber.font = FONT(14.5f);
    _NowPricelaber.frame = CGRectMake(FRAMEX(_Titlelaber), FRAMEY(_Titlelaber)+FRAMEH(_Titlelaber), FRAMEW(self)/3 + 10 , BIGLABEH);
    _NowPricelaber.textColor = [UIColor redColor];
    _NowPricelaber.font = FONT(15.0f);
    _OldPricelLaber.frame = CGRectMake(FRAMEX(_NowPricelaber) + FRAMEW(_NowPricelaber), FRAMEY(_NowPricelaber) + (FRAMEH(_NowPricelaber) - OLDH)/2 ,OLDW ,OLDH );
    _OldPricelLaber.font = FONT(11.0f);
    
    //旧价格横线
    UILabel *oldlaber = [[UILabel alloc] initWithFrame:CGRectMake(FRAMEX(_OldPricelLaber), FRAMEY(_OldPricelLaber)+FRAMEH(_OldPricelLaber)/2-1, FRAMEW(_OldPricelLaber), 2)];
    oldlaber.text = @"----";
    oldlaber.backgroundColor = CCCLOR;
    oldlaber.textColor = GrayCLOR;
    [self addSubview:oldlaber];
    
    _SaleLaber.frame = CGRectMake(FRAMEW(self) - OLDW + 10, FRAMEY(_NowPricelaber) + 7, OLDW - 10, BIGLABEH-15);
    
    _SaleLaber.backgroundColor = [UIColor redColor];
    _SaleLaber.textColor = WHITECOLOR;
    _SaleLaber.textAlignment = NSTextAlignmentCenter;
    _SaleLaber.font = FONT(14.0f);
    
    _SepLineimageview.frame = CGRectMake(FRAMEX(_NowPricelaber), FRAMEY(_NowPricelaber) + FRAMEH(_NowPricelaber) + 2, FRAMEW(self), 2);
    
    
    
    _Timeimageview.frame = CGRectMake(FRAMEX(_SepLineimageview), FRAMEY(_SepLineimageview) + 4,TIMAGE , TIMAGE);
    
    
    _TimeLaber.frame = CGRectMake(FRAMEX(_Timeimageview) + FRAMEW(_Timeimageview), FRAMEY(_Timeimageview) - 2, OLDW + 20, TIMAGE+ 5);
    _Titlelaber.font = FONT(10.0f);
    
    _Personimageview.frame = CGRectMake(FRAMEW(self) - OLDW - TIMAGE, FRAMEY(_Timeimageview), TIMAGE, TIMAGE);
    
    _PersonTotallaber.frame = CGRectMake(FRAMEX(_Personimageview)+FRAMEW(_Personimageview), FRAMEY(_Personimageview)-2, OLDW, TIMAGE + 5);
    _PersonTotallaber.font = FONT(10.0f);
    _PersonTotallaber.textAlignment = NSTextAlignmentCenter;

}


@end
