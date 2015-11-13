//
//  picView.m
//  TextKitPro
//
//  Created by li yajun on 15/11/10.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "picView.h"

@implementation picView

 

- (void)drawRect:(CGRect)rect {
   
     if(self.image)
    {
         CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        

 

        CGContextBeginPath(context);
    CGPathRef path = CGPathCreateWithRoundedRect(CGRectMake(10, 10, 150, 150), 20, 20, &CGAffineTransformIdentity);
        CGContextAddPath(context,  path);
        CGContextClosePath(context);
        CGContextClip( context);
         CGContextDrawImage(context, CGRectMake(10, 10, 150, 150), self.image.CGImage);
      
        
//        CGContextMoveToPoint (context, 0, 10);
//        CGContextAddLineToPoint (context, 50, 150);
//        CGContextAddLineToPoint (context, 100, 150);
//        
//        // Closing the path connects the current point to the start of the current path.
//        CGContextClosePath(context);
//        // And stroke the path
//        [[UIColor blackColor] setStroke];
//        //CGContextStrokePath(context);
//        [[UIColor redColor] setFill];
//        
//        CGContextDrawPath(context, kCGPathFillStroke);
        
    }
}
 

@end
