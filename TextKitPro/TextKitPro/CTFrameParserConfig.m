//
//  CTFrameParserConfig.m
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "CTFrameParserConfig.h"
#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
@implementation CTFrameParserConfig


- (id)init {
    self = [super init];
    if (self)
    {
        //默认配置
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 5.0f;
        _textColor = RGB(108, 108, 108);
    }
    return self;
}
@end
