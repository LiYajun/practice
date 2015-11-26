//
//  BubbleRichMsgView.h
//  TextKitPro
//
//  Created by li yajun on 15/11/11.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
/*********************************************************************\
 带气泡背景的UIbutton,识别tap手势和长按手势。包装了实际的RichMessageView
 版本：
 作者：yajun
\*********************************************************************/
#import <UIKit/UIKit.h>
#import "RichMessageView.h"

extern NSString *const CTDisplayViewImagePressedNotification; //点击图片通知
extern NSString *const CTDisplayViewLinkPressedNotification;  //点击链接(包括数字串，网址，邮箱地址)通知

typedef NS_ENUM(NSInteger, MsgFromWhere) {
    LeftMsg,         // left means the msg from other
    RightMsg,        // Right means the msg from you
};

@interface BubbleRichMsgView : UIButton

@property(strong,nonatomic) RichMessageView * richMessageView;  // rich View 实际的richText创建者


@property(assign) MsgFromWhere   msgFrom; //不同的消息,气泡背景图不一样
 
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
 通过模版数组来创造消息视图
 @param array
 */
+(BubbleRichMsgView *)createBubbleRichMsgView:( NSArray * ) array MsgFrom:(MsgFromWhere) msgfrom;
@end
