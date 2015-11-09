//
//  MyClassViewController.m
//  SchoolMessage
//
//  Created by Li Ying Ke on 15/6/21.
//  Copyright (c) 2015年 whwy. All rights reserved.
//

#import "MyClassViewController.h"
#import "MBProgressHUD+Add.h"

@interface MyClassViewController ()<UIWebViewDelegate>

@end

@implementation MyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的课堂";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-64)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    [self.view  addSubview:webView];
    webView.delegate =self;
    NSString *temp = [[AccountManager sharedInstance].LoginInfos getShipinUrl];
    
    NSString *b = [NSString stringWithFormat:@"-1@%@@whwy",[[AccountManager sharedInstance].LoginInfos getStudentId]];
    NSNumber *t = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    NSLog(@"time %d",t.intValue%999);
    NSString *bt = [b stringByAppendingString:[NSString stringWithFormat:@"%d",t.integerValue%999]];
    
    NSString *f = [__MD5(bt) uppercaseString];
    
    temp  = [NSString stringWithFormat:@"%@?b=%@&t=%ld&f=%@",temp,b,(long)t.integerValue,f];
    
    NSURL *url = [NSURL URLWithString:temp];
    //    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(NSString *)getNaaa:(NSString *)code
{
    int c= 0;
    NSString *str = @"";
    NSLog(@"code--%@--  i %d",code,code.length);
    for (int i = 0; i<code.length; i++) {
       NSString *temp =  [[__MD5([code substringWithRange:NSMakeRange(i, 1)]) uppercaseString] substringWithRange:NSMakeRange(c, 1)];
       
        NSLog(@"temp %@  i %d",temp,i);
        str = [str stringByAppendingString:temp];
        c++;
        if (c>31) {
            c = 0;
        }
    }
    NSLog(@"str %@",str);
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self showHint:@"读取失败"];
}


@end
