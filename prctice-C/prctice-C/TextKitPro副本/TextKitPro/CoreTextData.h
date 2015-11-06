//
//  CoreText.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@interface CoreTextData : NSObject


@property (assign, nonatomic) CTFrameRef  ctFrame;  //CTFrame

@property (assign, nonatomic) CGFloat height;       //预先计算的高度

@property (strong, nonatomic) NSArray * imageArray; //包含CoreTextImageData

@property (strong, nonatomic) NSArray * linkArray;  //包含CoreTextLinkData

@property (strong, nonatomic) NSAttributedString * content; //包含


@end
