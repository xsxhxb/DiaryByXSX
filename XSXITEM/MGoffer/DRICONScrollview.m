//
//  DRICONScrollview.m
//  MGoffer
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "DRICONScrollview.h"

@implementation DRICONScrollview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CrestHeadIconView];
    }
    return self;
}

#pragma -mark 首页Icon菜单装载数据
#define ICONLABERW 60
#define BTNW 28
#define BTNH 30
-(void)CrestHeadIconView{

    NSArray *iconimagearr = [NSArray arrayWithObjects:@"photo_icon_hot_selected",@"photo_icon_hot",@"photo_icon_new_selected",@"photo_icon_new",@"photo_icon_star_selected",@"photo_icon_star", nil];
    NSArray *iconlaebrarr = [NSArray arrayWithObjects:@"搭配达人",@"晒货达人",@"明星达人", nil];
    
    for (NSInteger i = 0; i <3; i++) {
        //icon图片按钮
        UIButton *iconbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconbtn.tag = i + 10 + 1;
        //icon图片文字
        iconbtn.frame = CGRectMake(10 + FRAMEW(self)/3 * i,(FRAMEH(self)-BTNH/2)/2, BTNW/2, BTNH/2);
        
        
        UILabel *laber = [[UILabel alloc] init];
        laber.frame = CGRectMake(FRAMEX(iconbtn) + FRAMEW(iconbtn) + 3, FRAMEY(iconbtn), ICONLABERW, FRAMEH(iconbtn));
        laber.backgroundColor = CCCLOR;
        laber.textAlignment = NSTextAlignmentCenter;
        laber.font = FONT(14.0f);
        laber.tag = i + 1;

        laber.userInteractionEnabled = YES;
        //设置菜单图片
        [iconbtn setImage:IMAGENAME(iconimagearr[i * 2 + 1]) forState:BTNNormal];
        [iconbtn setImage:IMAGENAME(iconimagearr[i*2]) forState:BTNSelect];
//        [iconbtn addTarget:self action:@selector(VIewSelect:) forControlEvents:BTNTouchIN];
        //切换菜单手势增加
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewSelect:)];
        [laber addGestureRecognizer:tap];
        
        laber.text = iconlaebrarr[i];
        laber.textAlignment = NSTextAlignmentLeft;
        [self addSubview:iconbtn];
        [self addSubview:laber];
    }
    
}


#pragma -mark 选择Icon视图切换菜单UI

-(void)ViewSelect:(UITapGestureRecognizer *)sender{
    
      for (NSInteger i = 0; i <3; i++){
          
        NSInteger m = 10 + i + 1;
        NSInteger k = i + 1;
       
        UIButton *btn = (UIButton *)[self viewWithTag:m];
        UILabel *laber =  (UILabel *)[self viewWithTag:k];
        btn.selected = NO;
        laber.textColor = BLACKCLOR;
    }
    
    UIButton *btn = (UIButton *)[self viewWithTag:(sender.view.tag + 10)];
    
    btn.selected = YES;
    
    UILabel *laber =  (UILabel *)[self viewWithTag:sender.view.tag];
    laber.textColor = REDCLOR;
    

    NSInteger currentpage = sender.view.tag - 1;
    
    NSLog(@"currentpage = %i",currentpage);
    if (_DRdelegate && [_DRdelegate respondsToSelector:@selector(ICONChangenum:)] ) {
        [_DRdelegate ICONChangenum:currentpage];
    }
}



@end
