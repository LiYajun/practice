//
//  CTFrameParserConfig.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
/******************************************************\
 数据核心创造类
 版本：
 作者：tangqiao
 整理：yajun
 \******************************************************/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTFrameParserConfig : NSObject


@property (nonatomic, assign) CGFloat width;        //配置的宽度

@property (nonatomic, assign) CGFloat fontSize;     //字体大小

@property (nonatomic, assign) CGFloat lineSpace;    //行间距

@property (nonatomic, strong) UIColor * textColor;  //字体颜色


@end
