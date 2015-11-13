//
//  CoreTextImageData.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CoreTextImageData : NSObject

@property (strong, nonatomic) NSString * name;  //图片文件名字

@property (nonatomic) NSUInteger position;      //图片前面的字符串中长度

@property (nonatomic) CGRect imagePosition;     //图片在 CoreText 中的坐标和长宽

@end
