//
//  RichMessageView.m
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "RichMessageView.h"
#import "CoreTextData.h"
#import "UIView+frameAdjust.h"
#import "CoreTextUtils.h"

NSString *const CTDisplayViewImagePressedNotification = @"CTDisplayViewImagePressedNotification";
NSString *const CTDisplayViewLinkPressedNotification = @"CTDisplayViewLinkPressedNotification";



@implementation RichMessageView

static CGFloat publicMaxWidth = 0;
 
+(void)setPublicMaxWidth:( CGFloat )width
{
    publicMaxWidth = width;
}
+(CGFloat)getPublicMaxWidth
{
    return  publicMaxWidth;
}
+(RichMessageView *)createMessageView:( NSArray * ) array
{
    if (publicMaxWidth == 0)
    {
        return  nil;
    }
    return [RichMessageView createMessageView: array withWidth: publicMaxWidth];
}

+(RichMessageView *)createMessageView:(NSArray *) array withWidth: (CGFloat)width
{
    if( width == 0 )
        return  nil;
    
    RichMessageView * ctView = [[RichMessageView alloc] initWithFrame: CGRectZero];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = width;
    
    CoreTextData * data = [ CTFrameParser parseFromArray: array config: config ];
  
    ctView.data = data;
    ctView.width  = data.width;
    ctView.height = data.height;
    ctView.backgroundColor = [UIColor clearColor];
    //背景图片
 
    return ctView;
}

//外部获取点击事件
-(void)getUserGuesture:(UIGestureRecognizer *) recognzier;
{
    NSLog(@"识别器状态：%d", recognzier.state);
    
    CGPoint point = [recognzier locationInView: self]; //转换成self上的坐标
    if(CGRectContainsPoint(self.bounds, point)==NO)
        return;
    
    if( [ recognzier isKindOfClass: [UITapGestureRecognizer class]] && recognzier.state == UIGestureRecognizerStateEnded  )
    {
        [ self userTapGestureDetected: recognzier];
    }
    if( [ recognzier isKindOfClass: [UILongPressGestureRecognizer class]] && recognzier.state == UIGestureRecognizerStateBegan)
    {
        [self userLongPressedGuestureDetected: recognzier ];
    }
}
//点击
-(void)userTapGestureDetected : (UIGestureRecognizer *) recognizer
{
    NSLog(@"点击...!");
    
    CGPoint point = [recognizer locationInView: self]; //转换成self上的坐标
 
    
    //1. 遍历每个图形区域，判断点击的坐标在其中没有
    for (CoreTextImageData * imageData in self.data.imageArray)
    {
        // 翻转坐标系，因为imageData中的坐标是CoreText的坐标系
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        // rect 的 
        // 检测点击位置 Point 是否在rect之内
        if (CGRectContainsPoint(rect, point))
        {
            NSLog(@"hit image");
            // 在这里处理点击后的逻辑
            NSDictionary *userInfo = @{ @"imageData": imageData };
            //发出通知
            [ [ NSNotificationCenter defaultCenter ] postNotificationName: CTDisplayViewImagePressedNotification
                                                                object: self userInfo : userInfo ];
            return;
        }
    }
    //2. 遍历每个链接区域，判断点击的坐标在其中没有
    CoreTextLinkData *linkData = [CoreTextUtils touchLinkInView: self atPoint:point data: self.data];
    if (linkData)
    {
        NSLog(@"hit link!");
        NSDictionary *userInfo = @{ @"linkData": linkData };

        // 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:CTDisplayViewLinkPressedNotification
                                                            object:self userInfo:userInfo];
        return;
    }

}
//长按
-(void)userLongPressedGuestureDetected:(UIGestureRecognizer *) recognzier
{
    NSLog(@"长按。。。");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch  locationInView: self];
    if(CGRectContainsPoint(self.bounds, point) == NO)
        return;
    [ self setState: State_TouchBegain ];  //触摸开始
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)setState:(touchState)state
{
    if(_state != state)
    {
        _state = state;
        [self setNeedsDisplay ];
    }
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.data == nil)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if(self.state == State_TouchBegain)
    {
        [self drawTouchArea];  //绘制触摸区域
    }
    
    CTFrameDraw(self.data.ctFrame, context);
   
    //绘制图片,如果有
    for (CoreTextImageData * imageData in self.data.imageArray)
    {
        UIImage *image = [UIImage imageNamed : imageData.name];
        if (image)
        {
            
            CGContextBeginPath(context);
            CGPathRef path = CGPathCreateWithRoundedRect(imageData.imagePosition,
                                                         10, 10,
                                                         &CGAffineTransformIdentity);
            //圆角路径遮罩
            CGContextAddPath(context,  path);
            CGContextClosePath(context);
            CGContextClip( context);

            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
    
    
}
//绘制触摸区域
-(void)drawTouchArea
{
    
}
@end
