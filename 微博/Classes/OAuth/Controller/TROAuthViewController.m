//
//  TROAuthViewController.m
//  微博
//
//  Created by Tory on 15/9/23.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TROAuthViewController.h"

#import "MBProgressHUD+MJ.h"

#import "TRAccountTool.h"

#import "TRRootTool.h"

#define TRAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define TRClient_id     @"3107245601"
#define TRRedirect_uri  @"http://www.baidu.com"
#define TRClient_secret @"e70ea1c176257fdeff7a054ab02c3a64"

@interface TROAuthViewController ()<UIWebViewDelegate>

@end

@implementation TROAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  展示登录的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    //  加载网页
    
    //  一个完整的URL：基本URL + 参数
    //  https://api.weibo.com/oauth2/authorize?client_id=3107245601&redirect_uri=http://www.baidu.com
    
    NSString *baseUrl = TRAuthorizeBaseUrl;
    NSString *client_id = TRClient_id;
    NSString *redirect_uri = TRRedirect_uri;
    
    //  拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    
    //  创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //  创建请求
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //  加载请求
    [webView loadRequest:request];
    
    //  设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //  提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

//  webView加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

//  webView加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

//  拦截webView请求
//  当WebView需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    //  获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length)
    {
        //  有code=
        //  code=64d5c338fa717797bbbc919765e27387
        //  0 + length
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        //  换取accessToken
        [self accessTokenWithCode:code];
        
        //  不会去加载回调界面
        return NO;
    }
    return YES;
}

/**
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
#pragma mark - 换取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
    [TRAccountTool accountWithCode:code success:^{
        //  进入主页或者新特性，选择窗口的根控制器
        [TRRootTool chooseRootViewController:TRKeyWindow];
    } failure:^(NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
