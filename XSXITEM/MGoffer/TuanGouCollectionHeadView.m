//
//  TuanGouCollectionHeadView.m
//  MGoffer
//
//  Created by mac on 14-6-30.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "TuanGouCollectionHeadView.h"

@implementation TuanGouCollectionHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // [self CreatView];
    }
    return self;
}

-(id)init{

    self = [super init];
    if (self) {
       // [self CreatView];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    UIScrollView *headscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    headscrollview.tag = 10;
    [self addSubview:headscrollview];
    [_modelarr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SuperModel *model = (SuperModel *)obj;
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(idx * FRAMEW(headscrollview) , 0, FRAMEW(self), 100)];
        //设置大图图片
        [imageview setImageWithURL:URLSTRING(model.showimage)];
        [headscrollview addSubview:imageview];

    }];
    headscrollview.contentSize = CGSizeMake(FRAMEW(headscrollview) * _modelarr.count, FRAMEH(headscrollview));
}


-(void)setModelarr:(NSArray *)modelarr{
    
    if (_modelarr != modelarr) {
        _modelarr = nil;
        _modelarr = modelarr;

    }
}



@end
