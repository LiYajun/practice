//
//  TUIButton.m
//  TextKitPro
//
//  Created by li yajun on 15/11/17.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "TUIButton.h"

@implementation TUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//
//-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    BOOL flag =  [super beginTrackingWithTouch:touch withEvent:event];
//    return  flag;
//}
//-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    BOOL flag = [super continueTrackingWithTouch:touch withEvent:event];
//    return  flag;
//}
//-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    [super endTrackingWithTouch:touch withEvent:event];
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TTTTTbutton touch touchesBegan !!!");
//    [super touchesBegan:touches withEvent:event];
    self.highlighted = YES;
    [self sendActionsForControlEvents: UIControlEventTouchDown];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TTTTButton touch Move !!!!");
//    [super touchesMoved:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"TTTTTbutton touch touchesEnded !!!");
//    [super touchesEnded: touches withEvent:event];
    self.highlighted = NO;
    
    [self sendActionsForControlEvents: UIControlEventTouchUpInside];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TTTTTbutton touch cancel...");
    [ super touchesCancelled: touches withEvent:event ];
}
@end
