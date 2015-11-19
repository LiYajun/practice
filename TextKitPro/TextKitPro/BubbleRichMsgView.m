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
    
 
    
    RichMessageView *  richMsgView = [RichMessageView createMessageView: array];
    NSInteger left = 5;   // 距离 左边边距
    NSInteger right = 16; // 距离 右边边距
    
    CGRect  bubbleFrame = CGRectMake(0, 0, richMsgView.data.width + left + right ,  richMsgView.data.height + 5*2);
    
    BubbleRichMsgView * bubbleView = [[BubbleRichMsgView alloc] initWithFrame :  bubbleFrame ];
    
 
    
    if(msgfrom == RightMsg)
    {
        UIImage * img = [[ UIImage imageNamed: @"chatto_bg_normal.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22) resizingMode: UIImageResizingModeTile ];
        [bubbleView setBackgroundImage: img forState: UIControlStateNormal ];
        richMsgView.x = left ;
        richMsgView.y = 5 ;
        
    }else
    {
        UIImage * img = [[ UIImage imageNamed: @"chatfrom_bg_normal.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10) resizingMode: UIImageResizingModeTile ];
        
        [bubbleView setBackgroundImage: img forState: UIControlStateNormal ];
        richMsgView.x = right ;
        richMsgView.y = 5 ;
        
    }
    bubbleView.msgFrom = msgfrom;
    [bubbleView addSubview: richMsgView];
    richMsgView.userInteractionEnabled = NO;
    bubbleView.richMessageView = richMsgView;
    
    
    richMsgView.backgroundColor = [UIColor orangeColor];
    bubbleView.backgroundColor =[UIColor blueColor];
    
    return  bubbleView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame: frame ];
    if(self)
    {
        [self addTarget:self action:@selector( ACT_touchupinside: ) forControlEvents:  UIControlEventTouchUpInside];
        
            //点击手势
            UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(userGestureDetected:)];
        
            [self addGestureRecognizer:tapRecognizer];
        
            //长按
            UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(userGestureDetected:)];
            longPressRecognizer.minimumPressDuration = 3;
            [self addGestureRecognizer:longPressRecognizer];
  
        
    }
    return  self;
}

//点击，长按
-(void)userGestureDetected:( UIGestureRecognizer *)sender
{
   
    [self.richMessageView getUserGuesture: sender];
    
}


-(void)ACT_touchupinside:(UIButton*)sender
{
    NSLog(@"touch up inside ......");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"btn  touchesBegan");
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"btn  touchesMoved");
      [super touchesMoved:touches withEvent:event];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    NSLog(@"btn  touchesEnded");
    [super touchesEnded:touches withEvent:event];

}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
 
    NSLog(@"btn  touchesCancelled");
    
    [super touchesCancelled:touches withEvent:event];
}

-(void)drawRect:(CGRect)rect
{
    static NSUInteger counter = 1;
    NSLog(@"\n绘制次数：%u\n", counter++);
    [ super drawRect: rect ];
}
@end
