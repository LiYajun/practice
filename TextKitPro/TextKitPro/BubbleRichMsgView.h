//
//  BubbleRichMsgView.h
//  TextKitPro
//
//  Created by li yajun on 15/11/11.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
/******************************************************\
 带气泡背景的UIbutton,识别tap手势和长按手势
 版本：
 作者：
\******************************************************/
#import <UIKit/UIKit.h>
#import "RichMessageView.h"

typedef NS_ENUM(NSInteger, MsgFromWhere) {
    LeftMsg,         // left means the msg from other
    RightMsg,        // Right means the msg from you
};

@interface BubbleRichMsgView : UIButton

@property(strong,nonatomic) RichMessageView * richMessageView;  // rich View


@property(assign) MsgFromWhere   msgFrom;
 
/*!
 设置所有的 bubbleMsgView 实例的最大宽度
 @param width 传入的宽度
 @return void
 */

+(void)setPublicMaxWidth:( CGFloat )width;
/*!
 获取设置所有的 bubbleMsgView 实例的最大宽度

 @return the max width
 */
+(CGFloat)getPublicMaxWidth;
/*!
 通过字符串来创造消息视图
 @param array
 */
+(BubbleRichMsgView *)createBubbleRichMsgView:( NSArray * ) array MsgFrom:(MsgFromWhere) msgfrom;
@end
