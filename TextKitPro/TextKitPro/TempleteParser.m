//
//  TempleteParser.m
//  TextKitPro
//
//  Created by li yajun on 15/11/19.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "TempleteParser.h"

@implementation TempleteParser
//分析内容
+(NSArray*)createTempleteArrayFrom:(NSString*)inStr
{
    if(inStr == nil || [inStr isEqualToString:@""])
        return  nil;
    
    
    NSScanner * scanner = [[NSScanner alloc] initWithString: inStr];
    NSCharacterSet * numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"]; //数字集合
    NSMutableArray * textArray = [[NSMutableArray alloc]init ];
    
    while (![scanner isAtEnd])
    {
        
    }
    return textArray;
}
@end
