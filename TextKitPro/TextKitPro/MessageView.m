//
//  MessageView.m
//  TextKitPro
//
//  Created by niko on 15/11/3.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "MessageView.h"
#import <CoreText/CoreText.h>

static CGFloat publicWidth = 0;

@implementation MessageView
// 设置所有的MessageView实例 公共的默认宽度
+(void)setPublicWidth:( CGFloat )width
{
    publicWidth = width;
}
// 创造消息视图,使用类的类的公共宽度
+(UIView *)createMessageView: ( NSString * ) content
{
    if(publicWidth == 0)
    {
        return  nil;
    }
    return [MessageView  createMessageView: content withWidth: publicWidth];
}

+(UIView *)createMessageView:(NSString *)content withWidth: (CGFloat)width
{
    if( width == 0 )
        return  nil;
    
    //NSMutableAttributedString 保存字符编码 和 属性
    NSMutableAttributedString * attrStr =  [[ NSMutableAttributedString alloc ] initWithString: content ];
    //设置字体
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, [attrStr length])];
    //字体颜色设置
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [attrStr length])];
    //字体背景颜色
    //[attrStr addAttribute: NSBackgroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0, attrStr.length)];
    //获取高度
    CGRect r = [attrStr boundingRectWithSize:  CGSizeMake(width, MAXFLOAT)
                                     options:  NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     context:  nil  ];
    //小数 取 整
    r.size.width =  ceilf(r.size.width);
    r.size.height=  ceilf(r.size.height);

    MessageView * mView  = [[ MessageView alloc ]initWithFrame : CGRectMake(5, 5, r.size.width, r.size.height) ];
    mView.attributedText = attrStr ;
    mView.numberOfLines = 0;
    //背景图片
    UIImageView * bubbleView = [[ UIImageView alloc ]init ];
    bubbleView.image = [[ UIImage imageNamed: @"chatto_bg_normal.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22) resizingMode: UIImageResizingModeTile ];
    
    r.size.width  += 20;
    r.size.height += 10;
    
    bubbleView.frame = r;
    
    [ bubbleView addSubview: mView ];
    
    return bubbleView;
}

-(void) drawTextInRect:(CGRect)rect
{
    [super drawTextInRect: rect];
}
-(void)drawRect:(CGRect)rect
{
    
    [ super drawRect: rect ];
    
    
}
@end
