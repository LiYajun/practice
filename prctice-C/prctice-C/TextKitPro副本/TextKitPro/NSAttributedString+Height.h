//
//  NSAttributedString+Height.h
//  TextKitPro
//
//  Created by niko on 15/11/2.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@interface NSAttributedString (Height)

-(CGFloat)boundingHeightForWidth:(CGFloat)inWidth;

@end
