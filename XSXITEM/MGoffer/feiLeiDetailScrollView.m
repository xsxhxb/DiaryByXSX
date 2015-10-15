//
//  feiLeiDetailScrollView.m
//  MGoffer
//
//  Created by mac on 14-7-5.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "feiLeiDetailScrollView.h"

@implementation feiLeiDetailScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

#pragma -mark set方法读取数据
//大数据
-(void)setIconModel:(AIGOUIconModel *)iconModel{
    if (_iconModel != iconModel) {
        _iconModel = nil;
        _iconModel = iconModel;
        NSArray *iconarr = _iconModel.listarr;
        for (NSInteger i = 0; i < 5; i++) {
            for (NSInteger j = 0; j < 3; j++) {
                NSInteger m = i * 3 + 1 + j;
                paymentlistmodel *model = iconarr[m - 1];
                UIImageView *iconImageView = (UIImageView *)[self viewWithTag:m];
                [iconImageView setImageWithURL:URLSTRING(model.iconimgjpg)];
                UILabel *laber = (UILabel *)[self viewWithTag:m + 100];
                laber.text = model.iconname;
            }
        }
    }
}

#pragma -mark 接受Recommend数据

-(void)setRecommendArr:(NSArray *)recommendArr{
    
    if (_recommendArr != recommendArr) {
        _recommendArr = nil;
        _recommendArr = recommendArr;
        for (NSInteger i = 0; i < _recommendArr.count; i++) {
            paymentlistmodel *model = _recommendArr[i];
            UIImageView *recommend = (UIImageView *)[self viewWithTag:200 + i];
            [recommend setImageWithURL:URLSTRING(model.iconimgjpg)];
        }
    }
}

#pragma -mark 判断是否Recommend
-(void)setIsRecommend:(BOOL)isRecommend{

    if (_isRecommend != isRecommend) {
        _isRecommend = isRecommend;
        [self ajustFrame];
    }
}

#define  ICON 60
#define  ICONLABERH 25
#define  BIGICNW 100



#pragma -mark 创建视图
-(void)creatView{
    
        for (NSInteger i = 0; i < 2; i++) {
            UIImageView *recommendImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 10 + i * (BIGICNW + 5) , 5 , BIGICNW, ICON)];
            recommendImageView.tag = 200 + i;
            [self addSubview:recommendImageView];
        }
        for (NSInteger i = 0; i < 5; i++) {
            for (NSInteger j = 0; j < 3; j++) {
                UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + ICON * j, 10 + ICON + (ICON + ICONLABERH) * i, ICON, ICON)];
                iconImageView.tag = i * 3 + 1 + j;
                UILabel *iconLaber = [[UILabel alloc] initWithFrame:CGRectMake(FRAMEX(iconImageView), FRAMEY(iconImageView)+FRAMEH(iconImageView), ICON, ICONLABERH)];
                iconLaber.tag = i * 3 + 1 + j + 100;
                [self addSubview:iconImageView];
                [self addSubview:iconLaber];
            }
        }

}

#pragma -mark 调整视图

-(void)ajustFrame{
    if (_isRecommend) {
        for (NSInteger i = 0; i < 2; i++) {
            UIImageView *recommend = (UIImageView *)[self viewWithTag:200 + i];
            recommend.frame = CGRectMake( 10 + i * (BIGICNW + 5)  , 5 , BIGICNW, ICON);
        }
        for (NSInteger i = 0; i < 5; i++) {
            for (NSInteger j = 0; j < 3; j++) {
                NSInteger m = i * 3 + 1 + j;
                UIImageView *iconImageView = (UIImageView *)[self viewWithTag:m];
                iconImageView.frame = CGRectMake(10 + (ICON + 10) * j, 10 + ICON + (ICON + ICONLABERH) * i, ICON, ICON);
                UILabel *laber = (UILabel *)[self viewWithTag:m + 100];
                laber.frame = CGRectMake(FRAMEX(iconImageView), FRAMEY(iconImageView)+FRAMEH(iconImageView), ICON, ICONLABERH);
                laber.font = FONT(13.5f);
                laber.textAlignment = NSTextAlignmentCenter;
            }
        }
        self.contentSize = CGSizeMake(FRAMEW(self), 10 + ICON + (ICON + ICONLABERH) * 5);
    }else{
        for (NSInteger i = 0; i < 2; i++) {
            UIImageView *recommend = (UIImageView *)[self viewWithTag:200 + i];
            recommend.frame = CGRectZero;
        }
        for (NSInteger i = 0; i < 5; i++) {
            for (NSInteger j = 0; j < 3; j++) {
                NSInteger m = i * 3 + 1 + j;
                UIImageView *iconImageView = (UIImageView *)[self viewWithTag:m];
                iconImageView.frame = CGRectMake(10 + (ICON + 10)* j, 5 + (ICON + ICONLABERH) * i, ICON, ICON);
                UILabel *laber = (UILabel *)[self viewWithTag:m + 100];
                laber.frame = CGRectMake(FRAMEX(iconImageView), FRAMEY(iconImageView)+FRAMEH(iconImageView), ICON, ICONLABERH);
            }
        }
        self.contentSize = CGSizeMake(FRAMEW(self), 5 + (ICON + ICONLABERH) * 5);
    }
}


@end
