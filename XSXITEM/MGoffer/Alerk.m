//
//  Alerk.m
//  UIxsx_exam
//
//  Created by qianfeng on 14-5-19.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "Alerk.h"

@implementation Alerk{

    UIAlertView *alert;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(id)initWithmessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    return alert;
}


//-(void)getname{
//    
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    UITextField *textField = [alert textFieldAtIndex:0];
//    textField.text = username;
//    [alert show];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
