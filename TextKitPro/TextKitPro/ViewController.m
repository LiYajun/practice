//
//  ViewController.m
//  TextKitPro
//
//  Created by niko on 15/10/29.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
 
#import "MessageView.h"
#import <Foundation/Foundation.h>

#import "UIView+frameAdjust.h"
#import "RichMessageView.h"

#import "BubbleRichMsgView.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UITextView * textView;
    UILabel * lab;
    UIImageView * imgView;
}
//NSLayoutManager用于管理NSTextStorage其中的文字内容的排版布局。
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
//测试 NSMutableAttributedString
    
#if defined(LYJ) 
    lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\ue348测试富文本测试富文本测试富文本测试富文本测测试富文本测试\n\n富文本测试富文本测试富文本测试富文本测试富文本测试富文本测试富文本测试富文本测试富文本测试富文本测试富文本测试\ue348富文本测试富文本测试富\n文本测试富文本测试富文本测试富文本 "];
    //为所有文本设置字体
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, [attributedString length])];
    //将“测试”两字字体颜色设置为蓝色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];
    //将“富文本”三个字字体颜色设置为红色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 3)];
    
    //在“测”和“试”两字之间插入一张图片
    NSString *imageName = @"58.png";
    UIImage * img = [UIImage imageNamed: imageName];
    
    NSTextAttachment *imageAttachment =  [[NSTextAttachment alloc]init];
    imageAttachment.image = img;
    imageAttachment.bounds = CGRectMake(0, 0, 150, 150);
    NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
   
 
    [attributedString appendAttributedString: imageAttributedString ];
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect  r =  [attributedString boundingRectWithSize:CGSizeMake(300, 99999) options:opts context: nil];
    lab.attributedText = attributedString ;
    
    double w = ceil(r.size.width);
    double h = ceil(r.size.height);
    lab.frame = CGRectMake(0, 0, w, h );
    lab.numberOfLines = 0;
    lab.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview: lab ];
#endif
    
    [BubbleRichMsgView setPublicMaxWidth: 200];
    BubbleRichMsgView * richMessageView = [BubbleRichMsgView createBubbleRichMsgView: @[
  @{
      @"color"   : @"red",
      @"content" : @"\ue403的1213344534534 ",
      @"size"    : [NSNumber numberWithInteger: 10],
      @"type"    : @"txt",
    },
  @{
      @"color"   : @"blue",
      @"content" : @"更版 \ue403版文件\ue403天热,文字的 ",
      @"size"    : [NSNumber numberWithInteger: 10],
      @"type"    : @"txt",
      },
  @{
      @"name"    : @"coretext-image-1.jpg",
      @"height"  : [ NSNumber numberWithInteger: 217/4 ],
      @"width"   : [ NSNumber numberWithInteger: 400/4 ],
      @"type"    : @"img",
      },
  @{
      @"color"   : @"blue",
      @"content"   : @"baidu",
      @"url"     : @"www.baidu.com",
      @"type"    : @"link",
      },
  ] MsgFrom: RightMsg];
    richMessageView.x = 20;
    richMessageView.y = 10;
   [self.view addSubview: richMessageView ];
    BubbleRichMsgView * richMessageViewL = [BubbleRichMsgView createBubbleRichMsgView:
    @[
      @{
        @"color"   : @"red",
        @"content" : @"\ue403的1213344534534 ",
        @"size"    : [NSNumber numberWithInteger: 10],
        @"type"    : @"txt",
        },
    @{
        @"color"   : @"blue",
        @"content" : @"更版 \ue403版文件\ue403天热,文字的 ",
        @"size"    : [NSNumber numberWithInteger: 10],
        @"type"    : @"txt",
        },
      @{
          @"color"    : @"blue",
          @"content"  : @"132234535667",
          @"size"   : [ NSNumber numberWithInteger: 14 ],
          @"type"    : @"number",
          },
    @{
        @"name"    : @"coretext-image-1.jpg",
        @"height"  : [ NSNumber numberWithInteger: 217/4 ],
        @"width"   : [ NSNumber numberWithInteger: 400/4 ],
        @"type"    : @"img",
        },

     ] MsgFrom: LeftMsg];
    richMessageViewL.x = 20;
    richMessageViewL.y = 300;
    [self.view addSubview: richMessageViewL];

    
    richMessageView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    
//    NSString *attrString =@"hello word";
//    
//    NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc]init];
//    paragraph.alignment=NSTextAlignmentCenter;//居中
//    
//    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:30],//文本的颜色 字体 大小
//                           NSForegroundColorAttributeName:[UIColor redColor],//文字颜色
//                           NSParagraphStyleAttributeName:paragraph,//段落格式
//                           NSBackgroundColorAttributeName:[UIColor blueColor],//背景色
//                           };
//    UILabel *lab = [[UILabel alloc] initWithFrame: CGRectMake(100, 20, 200, 80)
//                    ];
//    lab.attributedText = [[ NSAttributedString alloc] initWithString: attrString attributes: attrs ];
//    [self.view addSubview: lab];
    
//    picView * view = [[picView alloc] initWithFrame: CGRectMake(0, 300, 300, 200)];
//    view.image = [UIImage imageNamed:@"coretext-image-2.jpg"];
//    
// 
//    [self.view addSubview: view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
