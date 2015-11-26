//
//  CoreTextUtils.h
//  CoreTextDemo
//
//  Created by TangQiao on 13-12-22.
//  Copyright (c) 2013年 TangQiao. All rights reserved.
//
/******************************************************\
 数据核心创造类
 版本：
 作者：tangqiao
 整理：yajun
 \******************************************************/
#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"

@interface CoreTextUtils : NSObject

+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:( CoreTextData *)data;

+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

@end
