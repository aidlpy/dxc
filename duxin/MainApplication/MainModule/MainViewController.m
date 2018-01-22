//
//  MainViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MainViewController.h"
#import "ChatViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface MainViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    JSContext *_context;
}
@end

static NSString *url = @"https://www.baidu.com";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navView.middleBtn setImage:[UIImage imageNamed:Image(@"mainlogo")] forState:UIControlStateNormal];
    [self.navView.rightBtn setImage:[UIImage imageNamed:Image(@"customService")] forState:UIControlStateNormal];
    
    CGFloat tabbarHeight = Height_TabBar;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView)-tabbarHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    NSMutableURLRequest *requestUrl = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:requestUrl];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    [SVProgressHUD dismiss];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
   
    [SVProgressHUD dismiss];
    
    __weak typeof(self) weakSelf = self;
    
   //获取js的运行环境
   _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  //html调用无参数OC
   _context[@"test1"] = ^(){
      [weakSelf menthod1];
   };
   //html调用OC(传参数过来)
   _context[@"test2"] = ^(){
       NSArray * args = [JSContext currentArguments];//传过来的参数
       [args enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
       }];
       NSString * name = args[0];
        NSString * str = args[1];
       [weakSelf menthod2:name and:str];
    };
}

-(void)menthod1{
    
    
}

-(void)menthod2:(NSString *)name and:(NSString *)str{
    
    
    
    
}


-(void)nextTo{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",SERVICENUMBER];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
