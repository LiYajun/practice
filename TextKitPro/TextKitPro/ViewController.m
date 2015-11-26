//
//  ViewController.m
//  TextKitPro
//
//  Created by niko on 15/10/29.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
 

#import <Foundation/Foundation.h>

#import "UIView+frameAdjust.h"
#import "RichMessageView.h"

#import "BubbleRichMsgView.h"
#import "TempleteParser.h"


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
  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
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
    
    NSArray * array = [TempleteParser createTempleteArrayFrom: @"他的网址是http://www.iciba.com/concurrent121232343他的电话号码:23423423423423我的邮箱 233934323@qq.com你好34324334534534 http://blog.unieagle.net/2012/05/10/ios%E5%BC%80%E5%8F%91%E4%B8%AD%E5%AF%B9nsarray%E6%88%96%E8%80%85nsmutablearray%E4%B8%AD%E7%9A%84%E5%86%85%E5%AE%B9%E6%8E%92%E5%BA%8F/镜头today"];
    [BubbleRichMsgView setPublicMaxWidth: 200];
    BubbleRichMsgView * richMessageView = [BubbleRichMsgView createBubbleRichMsgView: array MsgFrom: RightMsg];
    richMessageView.x = 20;
    richMessageView.y = 50;
    
   [self.view addSubview: richMessageView ];
    
   [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(TapLink:) name:CTDisplayViewLinkPressedNotification object: nil];
   
   
    self.view.backgroundColor = [UIColor whiteColor];
 


    
}
-(void)TapLink:(NSNotification*) noti
{
    id obj = noti.userInfo;
}
-(void)test1
{
    NSLog(@"test 11111");
}
-(void)test2
{
    NSLog(@"test 22222");
}
-(void)ACT_TouchUpinside:(id)sender
{
    NSLog(@"touch inside .. ......   ............");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
