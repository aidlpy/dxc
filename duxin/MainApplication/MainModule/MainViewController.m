//
//  MainViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "CustomerServiceViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface MainViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    JSContext *_context;
    BOOL _isFirstLoad;
}
@end

static NSString *url = @"https://h5.37du.xin/";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _isFirstLoad = YES;
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navView.middleBtn setImage:[UIImage imageNamed:Image(@"mainlogo")] forState:UIControlStateNormal];
    [self.navView.rightBtn setImage:[UIImage imageNamed:Image(@"customService")] forState:UIControlStateNormal];
    
    CGFloat tabbarHeight = Height_TabBar;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView)-tabbarHeight)];
    _webView.delegate = self;

    [self.view addSubview:_webView];
    
    [SVProgressHUD show];
    _isFirstLoad = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [_webView loadRequest:request];


    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
 
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];

    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    if (_isFirstLoad == NO) {
        
        WebViewController *webViewVC = [[WebViewController alloc] init];
        webViewVC.urlString = request.URL.absoluteString;
        webViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewVC animated:YES];
        _isFirstLoad =  NO;
         return NO;

    }
    else{
        
        _isFirstLoad = NO;
        return YES;
       
    }
    
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
    _context[@"userLogin"] = ^(){
        [weakSelf userLogin];
    };
    
    _context[@"customerService"] = ^(){
        if(FetchToken != nil )
        {
            NSArray *args = [JSContext currentArguments];
            NSString *typeString = args[0];
            [weakSelf customerService:typeString];
        }
        else
        {
            [weakSelf userLogin];
        }
    };
}

-(void)customerService:(NSString *)type{
    
    CacheChatReceiverAdvatar(CustomServiceAdvatar);
    CustomerServiceViewController *vc =[[CustomerServiceViewController alloc] initWithConversationChatter:EMCUSTOMERNUMBERT conversationType:EMConversationTypeChat];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)userLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}


-(void)nextTo{
    [CallMobileTool callwithCustomAlert:SERVICENUMBER alertTitle:@"欢迎致电37度心客服热线" alertMessage:@"400-658-0180\n致电时间:早上9:00至晚上24:00" controller:self];
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
