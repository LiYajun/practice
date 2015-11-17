//
//  BubbleRichMsgView.m
//  TextKitPro
//
//  Created by li yajun on 15/11/11.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "BubbleRichMsgView.h"
#import "UIView+frameAdjust.h"
@implementation BubbleRichMsgView
@synthesize richMessageView = _richMessageView ;

static NSString * leftBubbleImage  = nil;
static NSString * rightBubbleImage = nil;



+(void)setPublicMaxWidth:( CGFloat )width
{
    if(width != 0)
    [RichMessageView setPublicMaxWidth: width];
}
+(CGFloat)getPublicMaxWidth
{
    return  [RichMessageView getPublicMaxWidth];
}
/*!
 通过字符串来创造消息视图
 @param array
 */
+(BubbleRichMsgView *)createBubbleRichMsgView:( NSArray * ) array MsgFrom:(MsgFromWhere) msgfrom
{
    
    BubbleRichMsgView * bubbleView = [[BubbleRichMsgView alloc] initWithFrame: CGRectZero ];
    
    RichMessageView *  richMsgView = [RichMessageView createMessageView: array];
    NSInteger left = 5;   // 距离 左边边距
    NSInteger right = 16; // 距离 右边边距
    CGRect  bubbleFrame = CGRectMake(0, 0, richMsgView.data.width + left + right ,  richMsgView.data.height + 5*2);
    
    UIImageView * imgView =  [[ UIImageView alloc ]initWithFrame: bubbleFrame];
    if(msgfrom == RightMsg)
    {
        imgView.image = [[ UIImage imageNamed: @"chatto_bg_normal.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22) resizingMode: UIImageResizingModeTile ];
        richMsgView.x = left ;
        richMsgView.y = 5 ;
        
    }else
    {
        imgView.image = [[ UIImage imageNamed: @"chatfrom_bg_normal.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10) resizingMode: UIImageResizingModeTile ];
        richMsgView.x = right ;
        richMsgView.y = 5 ;
        
    }
    bubbleView.msgFrom = msgfrom;
    

    [ imgView addSubview:  richMsgView ];
    
    bubbleView.frame = imgView.frame;
    
    [bubbleView addSubview: imgView];
    imgView.userInteractionEnabled = YES;
    bubbleView.bubbleBackView  = imgView;
    bubbleView.richMessageView = richMsgView;
    
    return  bubbleView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
