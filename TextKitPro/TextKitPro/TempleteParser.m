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
    //测试 正则表达式 获取字符串数据
    NSString* emailExp = @"([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4})";
    NSString* urlExp =   @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSString* numberExp = @"((?<=\\D)\\d{5,16}(?=\\D))";
    
    NSString * regulerExp  =  [NSString stringWithFormat:@"%@|%@|%@", emailExp, urlExp, numberExp];
    
    NSString *textString = inStr;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: regulerExp  options:0 error:&error];
    
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    NSArray* matchesArray = [ regex matchesInString: textString options: 0 range: NSMakeRange(0, [textString length])];
    for (NSTextCheckingResult* obj in matchesArray)
    {
        //NSLog(@"%llu", obj.resultType);
        NSRange resultRange = [obj rangeAtIndex: 0 ]; //等同于 firstMatch.range --- 相匹配的范围
        NSValue * value =  [ NSValue valueWithRange: resultRange];
        NSString * str  =  [ NSString stringWithString: [ textString substringWithRange: resultRange ] ];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:
                                      @{ @"pos": value,
                                         @"content": str } ];
        [array addObject: dict];
        NSLog(@"result=%@", str);
    }
    
    NSUInteger length = textString.length;
    
    NSRegularExpression *email_Regx    = [NSRegularExpression regularExpressionWithPattern: emailExp  options:0 error:&error];
    NSRegularExpression *url_Regx      = [NSRegularExpression regularExpressionWithPattern: urlExp    options:0 error:&error];
    NSInteger pos  = 0;
    NSMutableArray * simpleArray = [NSMutableArray new];
    
    for(int i=0; i < array.count; i++)//遍历特殊的字符数组
    {
        NSMutableDictionary* dict = [array objectAtIndex: i];
        NSString * str = dict[@"content"];
        
        if( [email_Regx numberOfMatchesInString: str  options: 0 range: NSMakeRange(0, str.length)] != 0 )
        {
            [dict setObject: @"email" forKey:@"type"];
            
        }else if( [url_Regx numberOfMatchesInString: str  options: 0 range: NSMakeRange(0, str.length)] != 0 )
        {
            [dict setObject: @"link" forKey:@"type"];
        }else
        {
            [dict setObject: @"number" forKey:@"type"];
        }
        
        
        //分析数组中的位置
        NSRange range = ((NSValue*) dict[@"pos"]).rangeValue;
        
        if(pos < range.location)
        {
            NSRange startRange = NSMakeRange(pos, 0);
            startRange.length = range.location - pos; //获取长度
            NSString * simpleStr = [textString substringWithRange: startRange];
            NSValue * value =  [ NSValue valueWithRange: startRange];
            NSString * str  =  [ NSString stringWithString: simpleStr ];
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:
                                          @{ @"pos": value,
                                             @"content": str,
                                             @"type": @"txt"} ];
            [simpleArray addObject: dict];
            NSLog(@"普通字符出串：%@", dict[@"content"]);
            pos = pos + startRange.length;
            pos = pos + range.length;
        }else if(pos == range.location)
        {
            pos = pos + range.length;
        }else
        {
            
        }
        NSLog(@"dict.content=%@",dict[@"content"]);
    }
    
    if(pos < length)
    {
        NSRange startRange = NSMakeRange(pos, 0);
        startRange.length = length - pos; //获取长度
        NSString * simpleStr = [textString substringWithRange: startRange];
        NSValue * value =  [ NSValue valueWithRange: startRange];
        NSString * str  =  [ NSString stringWithString: simpleStr ];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:
                                      @{ @"pos": value,
                                         @"content": str,
                                         @"type": @"txt"} ];
        [simpleArray addObject: dict];
        pos = pos + startRange.length;
    }
    NSLog(@"simipleArray=%@", simpleArray);
    [array  addObjectsFromArray: simpleArray];
    
    NSArray* newArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSMutableDictionary * dict1 = (NSMutableDictionary*)obj1;
        NSMutableDictionary * dict2 = (NSMutableDictionary*)obj2;
        NSUInteger pos1 = ((NSValue*)dict1[@"pos"]).rangeValue.location;
        NSUInteger pos2 = ((NSValue*)dict2[@"pos"]).rangeValue.location;
        if( pos1 <  pos2)
        {
            return  NSOrderedAscending;
        }else if(pos1 > pos2)
        {
            return   NSOrderedDescending;
        }else
        {
            return   NSOrderedSame;
        }
    }];
    for(NSMutableDictionary* dict in newArray)
    {
        NSLog(@"位置==%d", ((NSValue*)dict[@"pos"]).rangeValue.location );
        [dict removeObjectForKey:@"pos"];
    }
    return newArray;
}
@end
