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
      @"height"  : [ NSNumber numberWithInteger: 25 ],
      @"width"   : [ NSNumber numberWithInteger: 50 ],
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
    richMessageView.y = 50;
    
   [self.view addSubview: richMessageView ];
//   [ richMessageView.imgBtn  addTarget: self  action:@selector(ACT_TouchUpinside:) forControlEvents: UIControlEventTouchUpInside ];
   //  richMessageView.imgBtn.highlighted  = YES;
    
    BubbleRichMsgView * richMessageViewL = [BubbleRichMsgView createBubbleRichMsgView:
    @[
      @{
        //@"color"   : @"red",
        @"content" : @"\ue403的1213344534534 ",
       // @"size"    : [NSNumber numberWithInteger: 10],
        @"type"    : @"txt",
        },
    @{
        //@"color"   : @"blue",
        @"content" : @"更版 \ue403版文件\ue403天热,文字的 ",
        //@"size"    : [NSNumber numberWithInteger: 10],
        @"type"    : @"txt",
        },
      @{
         // @"color"    : @"blue",
          @"content"  : @"132234535667",
         // @"size"   : [ NSNumber numberWithInteger: 14 ],
          @"type"    : @"number",
          },
      @{
        @"name"    : @"coretext-image-1.jpg",
        @"height"  : [ NSNumber numberWithInteger: 217/4 ],
        @"width"   : [ NSNumber numberWithInteger: 400/4 ],
        @"type"    : @"img",
        },
      @{
          //@"color"    : @"blue",
          @"content"  : @"1322323123242344535667",
         // @"size"   : [ NSNumber numberWithInteger: 12 ],
          @"type"    : @"number",
          },
      @{
          //@"color"   : @"blue",
          @"content" : @"更版 \ue403版版文件版文件文版文件版文件版文件件\ue403天热,文字的 ",
         // @"size"    : [NSNumber numberWithInteger: 10],
          @"type"    : @"txt",
          },

     ] MsgFrom: LeftMsg];
    richMessageViewL.x = 20;
    richMessageViewL.y = 300;
    [self.view addSubview: richMessageViewL];
    
//    [ richMessageViewL.imgBtn addTarget:self action:@selector(ACT_TouchUpinside:) forControlEvents: UIControlEventTouchUpInside ];
    //richMessageViewL.imgBtn.highlighted = YES;
   
    self.view.backgroundColor = [UIColor whiteColor];
//    
//    UIButton * btn1 = [[UIButton alloc]initWithFrame: CGRectMake(0, 0, 100, 50)];
//    [btn1 setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
//    [btn1 setTitle: @"btn1:" forState:UIControlStateNormal ];
//    [btn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside ];
//    [self.view addSubview: btn1 ];
//    btn1.backgroundColor = [UIColor redColor ];
//    btn1.x = 10; btn1.y = 200;
//    
//    
//    UIButton * btn2 = [[UIButton alloc]initWithFrame: CGRectMake(0, 0, 100, 50)];
//    [btn2 setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
//    [btn2 setTitle: @"btn2:" forState:UIControlStateNormal ];
//    [btn2 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside ];
//    [ btn1 addSubview: btn2 ];
//    btn2.x = 10; btn2.y = 0;
//    btn2.backgroundColor = [ UIColor blueColor ];
    
    //组装一个字符串，需要把里面的网址解析出来
    
    NSString *urlString=@"www.blog.csdn.net/hitwhylz/article/details/46402309";
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    NSError *error;
    
 //    http+:[^\\s]* 这个表达式是检测一个网址的。
 //   NSString* str = @"http+:[^\\s]*";
//    NSString* str2= @"0\\d{2}-\\d{8}";
//    NSString* str3= @"\\bhi\\w*";
    
    #define KWebRegex    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
  
    #define number  @"\\b\\d{5,12}"
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: KWebRegex options:0 error:&error];
    
    if(regex != nil)
    {
        NSArray* array = [ regex matchesInString: urlString options: 0 range: NSMakeRange(0, [urlString length])];
        if (array)
        {
            for (NSTextCheckingResult* obj in array)
            {
                NSRange resultRange = [obj rangeAtIndex: 0 ]; //等同于 firstMatch.range --- 相匹配的范围
                
                //从urlString当中截取数据
                
                NSString *result = [urlString substringWithRange: resultRange];
                
                //输出结果
                
                NSLog(@"result = %@",result);
            }
            
        }
        
        
        
    }

    
//    NSError* error = nil;
//    NSDataDetector* linkDetector = [NSDataDetector dataDetectorWithTypes: NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber error:&error];
//    [linkDetector enumerateMatchesInString: someString  options: kNilOptions range:NSMakeRange(0,[someString length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//        if (result.URL) {
//            NSLog(@"url = %@",result.URL);
//        }
//        if (result.phoneNumber) {
//            NSLog(@"phone = %@",result.phoneNumber);
//        }
//    }];
    
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
