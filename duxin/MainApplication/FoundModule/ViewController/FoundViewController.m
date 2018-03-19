//
//  FoundViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "FoundViewController.h"
#import "CounselorViewController.h"
#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ShConsultViewController.h"
#import "ShPsychologicalMViewController.h"
#import "LoginViewController.h"
#import "ShConsultantDetailInfoViewController.h"

@interface FoundViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    BOOL _isFirstLoad;
    JSContext *_context;
}
@end

static NSString *url = @"https://h5.37du.xin/found";
@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    
    _isFirstLoad = YES;
    self.view.backgroundColor = [UIColor clearColor];
    [self.navView.middleBtn setTitle:@"发现" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
    CGFloat tabbarHeight = Height_TabBar;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView)-tabbarHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];

}



-(void)conselorAction:(UIButton *)btn{
    
    
    if (FetchToken == nil) {
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }
    else{
        CounselorViewController *vc =[[CounselorViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    _isFirstLoad =YES;
    NSMutableURLRequest *requestUrl = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:requestUrl];
    
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
        _isFirstLoad = YES;
        
    }
    else{
        
        _isFirstLoad = NO;
        
    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    return;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    __weak typeof(self) weakSelf = self;
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //html调用无参数OC
    _context[@"counselor"] = ^(){
        [weakSelf counselor];
    };
    
    _context[@"psychologicalMagazine"] = ^(){
        [weakSelf psychologicalMagazine];
    };
    
    _context[@"goConsultantHomePage"] = ^(){
        NSArray *args = [JSContext currentArguments];
        NSString *typeString = args[0];
        [weakSelf customerService:typeString];
    };
}

-(void)customerService:(NSString *)typeString{
    
    ShConsultantDetailInfoViewController *vc = [[ShConsultantDetailInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.strID = typeString;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)counselor{
    NSString *token = FetchToken;
    if (token != nil) {
        ShConsultViewController *vc = [ShConsultViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self userLogin];
        
    }


}

-(void)psychologicalMagazine{
    
    ShPsychologicalMViewController  *vc = [ShPsychologicalMViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)userLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
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
