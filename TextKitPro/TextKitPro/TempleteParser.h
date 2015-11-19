//
//  TempleteParser.h
//  TextKitPro
//
//  Created by li yajun on 15/11/19.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
/******************************************************\
 模板构造器,创建生产richText的中间模板
 版本：
 作者：
 \******************************************************/
#import <Foundation/Foundation.h>

@interface TempleteParser : NSObject
/*!
 根据输入的字符串，分析其内容，创建一个模板数组，其中元素是 Dictionary
 @param inStr 输入的字符串（通常是textField一类带输入功能的控件的text）
 */
+(NSArray*)createTempleteArrayFrom:(NSString*)inStr;
@end
