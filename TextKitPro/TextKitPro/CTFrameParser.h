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

/*!
 从模版文件构造核心数据对象
 @param path 模版文件(json文件)的路径
 @param config 基础配置的类对象
*/
+(CoreTextData*)parseTemplateFile: (NSString*) path config: (CTFrameParserConfig*) config;

/*!
 从模版文件构造核心数据对象
 @param array 包含NSDictionary类型的元素，NSDictionary纪录了每个不同text的样式，颜色等
 @param config 基础配置的类对象
 */
+(CoreTextData *)parseFromArray: (NSArray*) array config: (CTFrameParserConfig*) config;
@end
