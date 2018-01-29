//
//  FoundViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "FoundViewController.h"

@interface FoundViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

static NSString *url = @"http://h5.uat.37du.xin/#/found";
@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.navView.middleBtn setTitle:@"发现" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
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
    return;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [SVProgressHUD dismiss];
    
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
