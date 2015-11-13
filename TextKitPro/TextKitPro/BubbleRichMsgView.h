//
//  BubbleRichMsgView.h
//  TextKitPro
//
//  Created by li yajun on 15/11/11.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichMessageView.h"

typedef NS_ENUM(NSInteger, MsgFromWhere) {
    LeftMsg,         // left means the msg from other
    RightMsg,        // Right means the msg from you
};
@interface BubbleRichMsgView : UIView

@property(strong,nonatomic) RichMessageView * richMessageView;  // rich View

@property(strong,nonatomic) UIImageView  *  bubbleBackView;   // 气泡背景图片

@property(assign) MsgFromWhere   msgFrom;
 
/*!
 设置所有的 bubbleMsgView 实例的最大宽度
 @param width 传入的宽度
 @return void
 */

+(void)setPublicMaxWidth:( CGFloat )width;

/*!
 通过字符串来创造消息视图
 @param array
 */
+(BubbleRichMsgView *)createBubbleRichMsgView:( NSArray * ) array MsgFrom:(MsgFromWhere) msgfrom;
@end
