//
//  CTFrameParser.m
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>

#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"

NSString * const defaultFont = @"ArialMT";

//CTRun baseline 以上的高度
static CGFloat ascentCallback(void *ref)
{
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}
//CTRun baseline 以下的高度
static CGFloat descentCallback(void *ref)
{
    return 10;
}
//CTRun 宽度
static CGFloat widthCallback(void* ref)
{
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

@implementation CTFrameParser
//生成基本的属性字典，包括了行距的设置,默认颜色，默认字体
+ (NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config
{
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)defaultFont, fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing,    sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing,    sizeof(CGFloat), &lineSpacing }
    };
     
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor * textColor = config.textColor;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;

    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}
#pragma mark 外部调用接口
//每个Array的元素是 NSDictionary，是一个类型的元素
+(CoreTextData *)parseFromArray: (NSArray*) array config: (CTFrameParserConfig*) config
{
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *linkArray  = [NSMutableArray array];
    NSAttributedString * content = [self loadFromArray: array config: config imageArray:imageArray linkArray:linkArray];
    
    CoreTextData * data = [self parseAttributedContent: content config: config];
    
    data.imageArray = imageArray;
    data.linkArray  = linkArray;
    return  data;
}

//从模版文件构造核心数据对象
+(CoreTextData*)parseTemplateFile: (NSString*) path config: (CTFrameParserConfig*) config
{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *linkArray = [NSMutableArray array];
    
    //从文件生成属性字符,其实是 NSMutableAttributedString 类型
    NSAttributedString *content = [self loadTemplateFile: path          config: config
                                              imageArray: imageArray linkArray: linkArray];
    
    CoreTextData *data = [self parseAttributedContent: content config:config];
    
    data.imageArray = imageArray;
    data.linkArray  = linkArray;
    
    return  data;
}
//生成 整个 字符串
+(NSAttributedString *)loadFromArray: (NSArray *) array
                                 config: (CTFrameParserConfig*)config
                             imageArray: (NSMutableArray *)imageArray
                              linkArray: (NSMutableArray *)linkArray
{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    if(array)
    {
        //获取到的 是 数组对象
        if( [ array isKindOfClass: [NSArray class]] )
        {
            for(NSDictionary * dict in array)
            {
                NSString * type = dict[@"type"]; //获取当前的类型
                
                if( [type isEqualToString: @"txt"] )        //普通 文本
                {
                    //生成文本
                    NSAttributedString * as =[self parseAttributedTextFromNSDictionary: dict
                                                                                config:config];
                    
                    [result appendAttributedString: as];
                    
                }else if( [type isEqualToString: @"img"] )  //图片，只是能被点击
                {
                    // 创建 CoreTextImageData
                    CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
                    imageData.name     = dict[@"name"];
                    imageData.position =  result.length;
                    [imageArray addObject: imageData ];
                    // 创建图形数据的空白占位符，并且设置它的CTRunDelegate信息
                    NSAttributedString *as = [self parseImageDataFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                    
                }else if( [type isEqualToString: @"link"] ) //链接，本质是和文本一样， 能被点击
                {
                    NSUInteger startPos = result.length;
                    
                    NSAttributedString * as = [self parseAttributedTextFromNSDictionary:dict
                                                                                 config: config];
                    [result appendAttributedString: as];
                    //创建coreTextLinkData
                    NSUInteger length = result.length - startPos;
                    NSRange linkRange = NSMakeRange( startPos,  length );
                    CoreTextLinkData * linkData = [[CoreTextLinkData alloc] init];
                    linkData.title = dict[@"content"];
                    linkData.url   = dict[@"url"];
                    linkData.type = TypeUrl;
                    linkData.range = linkRange;
                    [linkArray addObject: linkData];
                    
                }else if( [type isEqualToString: @"number"]  )//一串数字，本质和文本一样，颜色样式不一样，能被点击
                {
                    
                    NSUInteger startPos = result.length;
                    
                    NSAttributedString * numberStr =[self parseAttributedNumberTextFromNSDictionary: dict
                                                                                            config:config];
                    [ result appendAttributedString : numberStr ];
                    
                    NSUInteger length = result.length - startPos;
                    NSRange linkRange = NSMakeRange( startPos,  length );
                    CoreTextLinkData * linkData = [[CoreTextLinkData alloc] init];
                    linkData.title = dict[@"content"];
                    linkData.url   = nil;
                    linkData.type = TypeNumber;
                    linkData.range = linkRange;
                    [linkArray addObject: linkData];
                    
                }
            }
        }
    }
    
 

    return result;
}
//生成 整个 字符串
+(NSAttributedString *)loadTemplateFile: (NSString *)path
                                  config: (CTFrameParserConfig*)config
                              imageArray: (NSMutableArray *)imageArray
                               linkArray: (NSMutableArray *)linkArray
{
    NSData * data = [NSData dataWithContentsOfFile:path];
    if(data)
    {
        NSArray * array = [NSJSONSerialization JSONObjectWithData: data
                       
                                                      options: NSJSONReadingAllowFragments
     
                                                        error: nil];
    
        return  [self loadFromArray: array config: config imageArray: imageArray linkArray: linkArray];
    }else
    {
        return  nil;
    }
}
#pragma mark 具体生成文本的方法
// 通过 字典 生成 带属性的文本 NSAttributedString
+ (NSAttributedString *)parseAttributedTextFromNSDictionary:(NSDictionary *)dict
                                                        config:(CTFrameParserConfig*)config
{
    NSMutableDictionary *attributes = [self attributesWithConfig:config];
    // set color
    
    UIColor *color = [ self colorFromTemplate: dict[@"color"] ];
    if (color)
    {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
        
    }
    // set font size
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)defaultFont, fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    
 

    return [[NSAttributedString alloc] initWithString:content attributes:   attributes ];
}
#pragma mark 具体生成一串数字的方法
// 通过 字典 生成 带属性的 连续数字(有可能是电话)文本 NSAttributedString
+(NSAttributedString *)parseAttributedNumberTextFromNSDictionary: (NSDictionary *)dict
                                                         config: (CTFrameParserConfig *) config
{
    NSMutableDictionary *attributes = [self attributesWithConfig:config];
    // set color
    UIColor *color = [ self colorFromTemplate: dict[@"color"] ];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    // set font size
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)defaultFont, fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        int  number =   kCTUnderlineStyleSingle;
        CFNumberRef numRef = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type, &number);
        attributes[ (id)kCTUnderlineStyleAttributeName ] = (__bridge id) numRef ;

        CFRelease(fontRef);
        CFRelease(numRef);
    }
    NSString *content = dict[@"content"];
    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithString:content attributes:attributes];
   
    return  attributeStr;
}
#pragma mark 具体生成链接的方法
// 通过 字典 生成 带属性的 链接文本 NSAttributedString
+(NSAttributedString *)parseAttributedLinkTextFromNSDictionary: (NSDictionary *)dict
                                                        config: (CTFrameParserConfig *) config
{
    NSMutableDictionary *attributes = [self attributesWithConfig:config];
    // set color
    UIColor *color = [ self colorFromTemplate: dict[@"color"] ];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    // set font size
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)defaultFont, fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}
#pragma mark 具体生成图片的占位 CTRun 的方法
//通过 字典 生成 给图形 占位的 空白文本
+ (NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict
                                                config:(CTFrameParserConfig*)config {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));
    
    // 使用0xFFFC作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString * content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary * attributes = [self attributesWithConfig:config];
    NSMutableAttributedString * space = [[NSMutableAttributedString alloc] initWithString:content
                                                                               attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1),
                                   kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}
//颜色字符转 UIColor
+ (UIColor *)colorFromTemplate:(NSString *)name {
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([name isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else {
        return nil;
    }
}
//从属性字符串来构造coreTextData
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config
        {
    // 创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    // 获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    CGFloat textWidth  = coreTextSize.width;
    // 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    // 将生成好的CTFrameRef实例和计算好的缓制高度保存到CoreTextData实例中，最后返回CoreTextData实例
    CoreTextData *data = [[CoreTextData alloc] init];
            
    data.ctFrame = frame;
    data.width = textWidth;
    data.height = textHeight;
    data.content = content;
    
    // 释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}


//创建CTFrame
+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(CTFrameParserConfig *)config
                                  height:(CGFloat)height {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}








































@end
