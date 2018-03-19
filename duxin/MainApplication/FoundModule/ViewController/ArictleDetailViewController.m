//
//  ArictleDetailViewController.m
//  duxin
//
//  Created by Zhang Xinrong on 12/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ArictleDetailViewController.h"
#import "LoginViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ArictleDetailViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    JSContext *_context;
    
    
}
@end

@implementation ArictleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the sview.
    [self initData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

-(void)initData{
    
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    NSString *usertoken =FetchToken;
    if(usertoken != nil){
        
        NSString *userid =FetchUserID;
        NSLog(@"~%@-%@",usertoken,userid);
        NSDictionary *dic = @{@"token":usertoken};
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            // 设定 cookie
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     [request.URL host], NSHTTPCookieDomain,
                                     [request.URL path], NSHTTPCookiePath,
                                     key,NSHTTPCookieName,
                                     obj,NSHTTPCookieValue,
                                     nil]];
            
            if (obj) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
            
            NSLog(@"cookie = %@",cookie);
        }];
        
        
    }
    else{
        NSArray *cookiesArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie *cookie in cookiesArray) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }        
    }
 

    return YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    __weak typeof(self) weakSelf = self;
    
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //html调用无参数OC
    _context[@"userLogin"] = ^(){
        [weakSelf userLogin];
    };
    

    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.navView setBackStytle:title rightImage:@"whiteLeftArrow"];
    
}

-(void)userLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

-(void)initUI{
    self.view .backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView))];
    _webView.delegate =self;
    [self.view addSubview:_webView];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [_webView loadRequest:urlRequest];
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
