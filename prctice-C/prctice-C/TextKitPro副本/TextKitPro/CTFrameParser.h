//
//  CTFrameParser.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
/******************************************************\
 数据核心创造类
 版本：
 作者：
\******************************************************/
#import <Foundation/Foundation.h>
@class  CoreTextData;
@class  CTFrameParserConfig;

@interface CTFrameParser : NSObject



+(CoreTextData*)parseTemplateFile: (NSString*) path config: (CTFrameParserConfig*) config;

@end
