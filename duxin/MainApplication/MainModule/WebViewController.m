//
//  WebViewController.m
//  duxin
//
//  Created by Zhang Xinrong on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "WebViewController.h"
#import "PaymentViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>
{
    JSContext *_context;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableURLRequest *requestUrl = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [_webView loadRequest:requestUrl];
}

-(void)initData{
    
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];

    _webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, SIZE.height-h(self.navView))];
    _webView.delegate =self ;
    [self.view addSubview:_webView];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.allHTTPHeaderFields);
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
  //  __weak typeof(self) weakSelf = self;
    
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    _context[@"customerService"] = ^(){
        NSArray *args = [JSContext currentArguments];
        NSLog(@"args===>%@",args);
        //[weakSelf customerService];
    };
    
   
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.navView setBackStytle:title rightImage:@"whiteLeftArrow"];
}

-(void)pushChatRoomNickName:(NSArray *)args{

    if (args.count >= 3) {
        
        
        
    }
    else
    {
        [SVHUD showErrorWithDelay:@"参数失败" time:0.8];
        
    }
    

}

-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
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
