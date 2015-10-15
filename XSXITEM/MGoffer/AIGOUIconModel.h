//
//  AIGOUIconModel.h
//  MGoffer
//
//  Created by mac on 14-6-27.
//  Copyright (c) 2014年 xsx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIGOUIconModel : NSObject
@property(nonatomic ,strong) NSString *normalicon;
@property(nonatomic ,strong) NSString *selecticon;
@property(nonatomic ,strong) NSString *title;
@property(nonatomic ,strong) NSString *text;
@property(nonatomic ,strong) NSString *type;
@property(nonatomic ,strong) NSMutableArray *listarr;

-(id)init;
@end
