//
//  RichMessageView.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"

extern NSString *const CTDisplayViewImagePressedNotification;
extern NSString *const CTDisplayViewLinkPressedNotification;

@interface RichMessageView : UIView


@property(strong, nonatomic) CoreTextData * data; //绘制相关信息，


/*!
 设置所有的MessageView实例的最大宽度
 @param width 传入的宽度
 @return void
 */
+(void)setPublicMaxWidth:( CGFloat )width;

/*!
 通过字符串来创造消息视图
 @param array 
 */
+(RichMessageView *)createMessageView:( NSArray * ) array;


@end
