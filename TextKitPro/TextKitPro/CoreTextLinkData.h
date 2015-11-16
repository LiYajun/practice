//
//  CoreTextLinkData.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LinkType)
{
    TypeUrl = 0,
    TypeNumber = 1,
};

@interface CoreTextLinkData : NSObject

@property (assign, nonatomic) LinkType   type;  //表明是一串数字，还是一个url
@property (strong, nonatomic) NSString * title; //链接名字
@property (strong, nonatomic) NSString * url;   //链接地址
@property (assign, nonatomic) NSRange    range; //
@end
