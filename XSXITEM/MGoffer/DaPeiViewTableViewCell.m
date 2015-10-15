//
//  DaPeiViewTableViewCell.m
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "DaPeiViewTableViewCell.h"

@implementation DaPeiViewTableViewCell{
    
    BOOL tagexit;

}


/*-----------数据加载-----------*/
-(void)setModel:(AGListCellModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
        
        NSMutableString *imagestr = [NSMutableString stringWithString:_model.showimage];
        
        if ([_model.showimage rangeOfString:@"_320x999.webp"].location != NSNotFound) {
            
            NSRange imagerange = [_model.showimage rangeOfString:@"_320x999.webp"];
            
            //imagerange.location = imagerange.location + imagerange.length;
            //imagerange.length = imagestr.length - imagerange.location;
            [imagestr replaceCharactersInRange:imagerange withString:@""];
        }
        
        
        [_Headimageiview setImageWithURL:URLSTRING(imagestr)];
        [_Personimageview setImageWithURL:URLSTRING(_model.avatar)];
        _Personnamelaber.text = _model.uname;
        if (_model.tagtextarr.count != 0) {
            tagexit = YES;
            _TagLaber.text = [_model.tagtextarr lastObject];
        }else{
            tagexit = NO;
        }
        _ShopDetaillaber.text = _model.title;
        
        _CDlaber.text = [NSString stringWithFormat:@"%i件穿搭",_model.cphotonum];
        
        _Favlaber.text = [NSString stringWithFormat:@"%i",_model.cfavnum];
    }
    self.backgroundColor = WHITECOLOR;
    [self layoutSubviews];
}

/*--------------视图重新布局-------------*/

#define HEADIMAGEH 180
#define HEADLABERW 60
#define HEADLABERH 22
#define PERSONH 64
#define PERSONLABERW 100
#define ICONW 13

#define ICONLABERW 80


-(void)layoutSubviews{
    
    
    _Headimageiview.frame = CGRectMake(5, 0, FRAMEW(self) - 10, HEADIMAGEH );
    
    //没有显示则隐藏
    if (tagexit == NO) {
        _TagLaber.frame = CGRectZero;
        _TagLaber.textColor = CCCLOR;

    }else{
        _TagLaber.frame = CGRectMake(FRAMEX(_Headimageiview), FRAMEY(_Headimageiview), HEADLABERW, HEADLABERH);
        _TagLaber.textAlignment = NSTextAlignmentCenter;
        _TagLaber.backgroundColor = REDCLOR;
        _TagLaber.textColor = WHITECOLOR;
        _TagLaber.font = FONT(13.0f);
    }

    if (_model.cphotonum == 0) {

        _Personimageview.frame = CGRectZero;
        _Personnamelaber.frame = CGRectZero;
        _ShopDetaillaber.frame = CGRectZero;
        _Sepatateimageview.frame = CGRectZero;
        _CDimageview.frame  =CGRectZero;
        _CDlaber.frame = CGRectZero;
        _Favimageview.frame = CGRectZero;
        _Favlaber.frame = CGRectZero;
        
    }else{
        _Personimageview.frame = CGRectMake(FRAMEX(_Headimageiview)+10, FRAMEY(_Headimageiview)+FRAMEH(_Headimageiview)- PERSONH/6, PERSONH/2, PERSONH/2);
        
        _Personimageview.layer.cornerRadius = 15.0f;
        
        _Personimageview.clipsToBounds = YES;
        _Personimageview.contentMode = UIViewContentModeScaleAspectFit;
        _Personnamelaber.frame = CGRectMake(FRAMEX(_Personimageview) + FRAMEW(_Personimageview), FRAMEY(_Personimageview) + 10, PERSONLABERW ,HEADLABERH );
        _Personnamelaber.font = FONT(11.0f);
        _Personnamelaber.textAlignment = NSTextAlignmentCenter;
            
        _ShopDetaillaber.font = FONT(13.0f);
        
       // NSLog(@"height = %i",_model.titleH);
        _ShopDetaillaber.numberOfLines = 0;
        
        _ShopDetaillaber.frame = CGRectMake(FRAMEX(_Personimageview), FRAMEY(_Personimageview)+FRAMEH(_Personimageview) , _model.titlesize.width, _model.titlesize.height);
            
        
            
        _Sepatateimageview.frame = CGRectMake(FRAMEX(_ShopDetaillaber), FRAMEY(_ShopDetaillaber)+FRAMEH(_ShopDetaillaber)+1, FRAMEW(_ShopDetaillaber), 2);
        //穿衣指数
        _CDimageview.frame = CGRectMake(FRAMEX(_Sepatateimageview), FRAMEY(_Sepatateimageview) + 5, ICONW, ICONW);
        
        _CDlaber.frame = CGRectMake(FRAMEX(_CDimageview) + FRAMEW(_CDimageview), FRAMEY(_CDimageview), ICONLABERW, ICONW + 5);
        _CDlaber.textAlignment = NSTextAlignmentCenter;
        _CDlaber.textColor = REDCLOR;
        _CDlaber.font = FONT(13.0f);
        
        _Favimageview.frame = CGRectMake(FRAMEW(self) - ICONW * 2 - ICONW * 2, FRAMEY(_CDimageview), ICONW , ICONW);

        
        _Favlaber.frame = CGRectMake(FRAMEX(_Favimageview) + FRAMEW(_Favimageview), FRAMEY(_Favimageview), ICONW * 2 + 10, ICONW + 5);
        _Favlaber.font = FONT(12.0f);
        _Favlaber.textAlignment = NSTextAlignmentCenter;
    }

}

@end
