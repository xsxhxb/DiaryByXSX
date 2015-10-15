//
//  FeiLeiMenuView.m
//  MGoffer
//
//  Created by mac on 14-7-1.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "FeiLeiMenuView.h"

@implementation FeiLeiMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatView];
    }
    return self;
}

#define ICONW 20
#define ICONH 20
#define LABERW 40
#define LABERH 30

-(void)CreatView{

    for (NSInteger i = 0; i < 7; i++) {
        UIButton *iconimagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconimagebtn.frame = CGRectMake(5, 10 + i * ICONH * 2, ICONW, ICONH);
        iconimagebtn.tag = i + 1;
        UILabel *iconlaber = [[UILabel alloc] initWithFrame:CGRectMake(FRAMEX(iconimagebtn) + FRAMEW(iconimagebtn), FRAMEY(iconimagebtn) - 4, LABERW, LABERH)];
        iconlaber.tag = i + 10 + 1 ;
        iconlaber.font = FONT(13.0f);
        iconlaber.textAlignment = NSTextAlignmentCenter;
        //增加手势
        [iconimagebtn addTarget:self action:@selector(MENUchage:) forControlEvents:BTNTouchIN];
        
        [self addSubview:iconimagebtn];
        [self addSubview:iconlaber];
    }
}

-(void)setMenuArr:(NSArray *)menuArr{
    
    if (_menuArr != menuArr) {
        _menuArr = nil;
        _menuArr = menuArr;
        for (NSInteger i = 0; i < _menuArr.count; i++) {
            paymentlistmodel *model = _menuArr[i];
            NSInteger m = i + 1;
            UIButton *iconimagebtn = (UIButton *) [self viewWithTag:m];
            [iconimagebtn setImage:model.iconnormalimage forState:BTNNormal];
            [iconimagebtn setImage:model.iconselectimage  forState:BTNSelect];
            UILabel *iconlaber = (UILabel *)[self viewWithTag:m + 10 ];
            iconlaber.text = model.iconname;
        }
    }
}

//代理回传

-(void)MENUchage:(UIButton *)sender{
    
    for (NSInteger i = 0; i < _menuArr.count; i++) {
        
        NSInteger m = i + 1;
        UIButton *iconbtn = (UIButton *) [self viewWithTag:m];
        iconbtn.selected = NO;
        UILabel *iconlaber = (UILabel *)[self viewWithTag:m + 10 ];
        iconlaber.textColor = BLACKCLOR;
    }

    sender.selected = YES;
    UILabel *laber = (UILabel *)[self viewWithTag:sender.tag + 10];
    laber.textColor = REDCLOR;
    if (_delegate && [_delegate respondsToSelector:@selector(FeiLeiMenuViewChange:)]) {
        //切换视图
        [_delegate FeiLeiMenuViewChange:sender.tag - 1];
    }
}


@end
