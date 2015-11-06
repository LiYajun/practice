//
//  ViewController.m
//  TextKitPro
//
//  Created by niko on 15/10/29.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "NSAttributedString+Height.h"
#import "MessageView.h"
#import "TTTAttributedLabel/TTTAttributedLabel.h"
#import <Foundation/Foundation.h>

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
//    NSTextStorage * textStorage = [NSTextStorage new];
//    
//    NSLayoutManager * layoutManager = [NSLayoutManager new];
//
//    [textStorage addLayoutManager: layoutManager];
//    
//    NSTextContainer * textContainer = [ [NSTextContainer alloc] init]; //: CGSizeMake(310, 450)];
//  
//    [layoutManager addTextContainer: textContainer ];
//    [textStorage setAttributedString: [[NSAttributedString alloc]initWithString:
//                                       @"13889343332我喜欢打啊打啊啊啊打啊啊啊打啊"
//                                       "啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊"
//                                       "啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊"
//                                       "啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打"
//                                       "啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊结束了吧"] ];
//
//    
//    [textStorage addAttribute: NSForegroundColorAttributeName  value: [UIColor redColor] range: NSMakeRange(0, 5)];
//    //字体类型
//    [textStorage addAttribute: NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size: 12] range:NSMakeRange(0, textStorage.string.length)];
//    //字体背景颜色
//    [textStorage addAttribute: NSBackgroundColorAttributeName value: [UIColor blueColor] range: NSMakeRange(0, 2)];
//    //字体下划线
//    //[textStorage addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternDot) range:NSMakeRange(0, 8)];
//    
//    NSMutableParagraphStyle* para = [NSMutableParagraphStyle new];
//    para.headIndent = 10;
//    para.firstLineHeadIndent = 10;
//    para.paragraphSpacingBefore = 5;
//    para.tailIndent = -1;
//    para.lineBreakMode = NSLineBreakByWordWrapping;
////    [textStorage  addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0,textStorage.string.length)];
//     CGRect r = [textStorage boundingRectWithSize:  CGSizeMake(320, 10000)
//                                          options:  NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
//                         ∑                 context:  nil  ];
    
     //textContainer.size = r.size;
    
//    imgView = [[UIImageView alloc]initWithFrame: CGRectMake(70, 90, 50, 50)];
//    imgView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview: imgView];
//    textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 30, ceilf(r.size.width), ceilf(r.size.height)+3)];
//    textView.scrollEnabled = NO;
//    textView.attributedText = textStorage ;
//    [ self.view  addSubview:  textView     ];
//    textView.backgroundColor = [UIColor lightGrayColor];
    
//    NSString *str =  @"13889343332我喜欢打啊∑∑打啊啊啊打啊啊啊打啊"
//    "啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊"
//    "啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊"
//    "啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打"
//    "啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊打啊啊啊结束了吧";
//    
//    UILabel * Lab = [[UILabel alloc] initWithFrame: CGRectMake(0, 30, 100, 568)];
//    Lab.font = [UIFont systemFontOfSize: 45];
//   
//    Lab.attributedText = [[NSAttributedString alloc] initWithString: str ];
//    
//    [ self.view addSubview: Lab ];
//    Lab.numberOfLines = 0;
//    Lab.backgroundColor = [UIColor lightGrayColor];
 
    //设置环绕的路径
//     CGRect rect = CGRectMake(50, 100, 100, 100);
//    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect];
//    textView.textContainer.exclusionPaths = @[path];
   
    
    
//    NSLayoutManager *otherLayoutManager = [NSLayoutManager new];
//    [ textStorage  addLayoutManager: otherLayoutManager];
//    NSTextContainer *otherTextContainer = [NSTextContainer new];
//    [otherLayoutManager  addTextContainer: otherTextContainer ];
//    
//    UITextView * textView2 = [[ UITextView alloc ]initWithFrame:  CGRectMake(100, 30, 100, 300) textContainer:otherTextContainer ];
//    textView2.scrollEnabled = NO;
//    [self.view addSubview: textView2];
    
//    textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
 
    
//    UITextField * field = [UITextField new];
//    field.frame = CGRectMake(100, 100, 80, 50);
//     [self.view addSubview: field];

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
    
    [MessageView setPublicWidth: 90 ];
    UIView * view = [MessageView createMessageView: @"我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢我喜欢\ue302这个\ue302\ue302喜欢我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢欢喜我喜欢\ue302这个\ue302\ue302\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜2喜欢\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜喜欢喜欢喜\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢欢喜我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢欢喜欢我喜欢\ue302这个\ue302\ue302喜欢喜欢喜欢喜欢喜欢喜欢"];
    CGRect f = CGRectMake( 20, 40,   view.frame.size.width, view.frame.size.height);
    view.frame = f;
    view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview: view ];
    
 
 
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
