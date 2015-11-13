//
//  MessageView.h
//  TextKitPro
//
//  Created by niko on 15/11/3.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
/******************************************************\
             基于TextKit实现的富文本消息框
 版本： v1.0
 作者： yajun
\******************************************************/
 
#import <UIKit/UIKit.h>

@interface MessageView : UILabel

/*!
 设置所有的MessageView实例的默认宽度
 @param width 传入的宽度
 */
+(void)setPublicWidth:( CGFloat )width;

/*!
 通过字符串来创造消息视图
 @param content 传入的字符串
*/
+(UIView *)createMessageView:( NSString * ) content;
@end
