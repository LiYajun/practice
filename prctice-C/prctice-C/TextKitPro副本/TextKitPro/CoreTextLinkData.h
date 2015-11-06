//
//  CoreTextLinkData.h
//  TextKitPro
//
//  Created by li yajun on 15/11/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject


@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * url;
@property (assign, nonatomic) NSRange    range;
@end
