//
//  MytabBarController.m
//  MeiTuan
//
//  Created by qianfeng on 14-6-2.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//




#import "MytabBarController.h"

@interface MytabBarController ()

@end

@implementation MytabBarController{
    UIImageView *bgview;
}

-(id)init{
    self = [super init];
    if (self) {
        self.tabBar.hidden = YES;
        _controlviewarr = [[NSMutableArray alloc] init];
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setViewControllers:(NSArray *)viewControllers{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in viewControllers) {
        UIViewController *viewc = [dic objectForKey:VIEWCONTROL];
        MytableModel *model = [[MytableModel alloc] init];
        model.normalimage = [dic objectForKey:NORMAL];
        model.selectimage = [dic objectForKey:SELECT];
        model.control = viewc;
        [_controlviewarr addObject:model];
        [arr addObject:viewc];
    }
    
    [super setViewControllers:arr];
    [self creattablebar];
   
}


-(void)creattablebar{
    //bgview坐标重写
    CGRect rect = CGRectMake(0, 480-44, 320, 44);
    bgview = [[UIImageView alloc] initWithFrame:rect];
    bgview.userInteractionEnabled = YES;
    bgview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    bgview.backgroundColor = GrayCLOR;
    [self.view addSubview:bgview];
    [self creatbutton];
  
}

#define HEIGHT bgview.frame.size.height/2+5

#define LABERHEIGHT bgview.frame.size.height/2-5

-(void)creatbutton{
    
    NSArray *labertextarr = [NSArray arrayWithObjects:@"爱逛",@"分类",@"达人",@"购物车",@"我的",nil];
    float width = (320 - _controlviewarr.count * 15)/_controlviewarr.count;
    for (NSInteger i = 0; i < _controlviewarr.count; i++) {
        MytableModel *model = [_controlviewarr objectAtIndex:i];
        float x = 10 + (width + 15)*i;
        CGRect rect = CGRectMake(x, 0 , width, HEIGHT);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        [button setImage:[UIImage imageNamed:model.normalimage]  forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:model.selectimage]  forState:UIControlStateSelected];
        button.frame = rect;
        [button addTarget:self action:@selector(viewimagechose:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:button];
        
        
        UILabel *laber = [[UILabel alloc] init];
        laber.tag = 100 + 10 + i;
        laber.font = [UIFont systemFontOfSize:14.5f];
        laber.text = [labertextarr objectAtIndex:i];
        laber.textAlignment = NSTextAlignmentCenter;
        CGRect rectlaber = CGRectMake(x, button.frame.size.height + button.frame.origin.y , width+10, LABERHEIGHT);
        laber.frame = rectlaber;
        [bgview addSubview:laber];
    }
    UIButton *button = (UIButton *)[bgview viewWithTag:100];
    button.selected = YES;
   
}




-(void)viewimagechose:(UIButton *)sender{

    NSArray *arr = [bgview subviews];
    for (UIView *view in arr) {
        if ([view isKindOfClass:[sender class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    
    for (NSInteger i = 0; i < _controlviewarr.count; i ++ ) {
        
        UILabel *laber = (UILabel *)[self.view viewWithTag:100 + 10 + i];
        if (btn.selected == YES && btn.tag == (laber.tag - 10)) {
            laber.textColor = [UIColor redColor];
        }else{
            laber.textColor = [UIColor blackColor];
        }
    }
       self.selectedIndex = btn.tag - 100;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
