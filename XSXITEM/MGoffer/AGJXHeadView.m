//
//  AGJXHeadView.m
//  MGoffer
//
//  Created by mac on 14-7-4.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import "AGJXHeadView.h"

@implementation AGJXHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIScrollView *JXScrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:JXScrollview];
    for (NSInteger i = 0; i < _modelarr.count; i++) {
        SuperModel *headmodel = _modelarr[i];
        UIImageView *headimageview = [[UIImageView alloc] initWithFrame:CGRectMake(headmodel.showW * i, 0, headmodel.showW, headmodel.showH)];
        [headimageview setImageWithURL:[NSURL URLWithString:headmodel.showimage]];
        [JXScrollview addSubview:headimageview];
    }
    SuperModel *model = [_modelarr lastObject];
    JXScrollview.frame = CGRectMake(0,0, FRAMEW(JXScrollview), model.showH);
    JXScrollview.contentSize = CGSizeMake(model.showW * _modelarr.count, model.showH);
    JXScrollview.pagingEnabled = YES;
    JXScrollview.showsHorizontalScrollIndicator = NO;
    JXScrollview.showsVerticalScrollIndicator = NO;
    JXScrollview.bounces = NO;

}

-(void)setModelarr:(NSArray *)modelarr{

    if (_modelarr != modelarr) {
        _modelarr = nil;
        _modelarr = modelarr;
    }
}


@end
