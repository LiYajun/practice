//
//  CoreText.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//   
//
/******************************************************\
 数据核心
 版本：
 作者：tangqiao
 整理：yajun
\******************************************************/
#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"
 

#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"

@interface CoreTextData : NSObject


@property (assign, nonatomic) CTFrameRef  ctFrame;  //CTFrame

@property (assign, nonatomic) CGFloat width ;       //预先计算的整个CTFrame 宽度

@property (assign, nonatomic) CGFloat height;       //预先计算的整个CTFrame 高度

@property (strong, nonatomic) NSArray * imageArray; //包含CoreTextImageData

@property (strong, nonatomic) NSArray * linkArray;  //包含CoreTextLinkData

@property (strong, nonatomic) NSAttributedString * content; //包含的具体字符串内容


@end
