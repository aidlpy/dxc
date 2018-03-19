//
//  DelegateViewController.m
//  37duxinB
//
//  Created by Zhang Xinrong on 03/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "DelegateViewController.h"

@interface DelegateViewController ()

@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"用户协议" rightImage:@"whiteLeftArrow"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,bottom(self.navView), SIZE.width, SIZE.height-h(self.navView))];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"delegate" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [webView loadHTMLString:htmlString baseURL:url];
    [self.view addSubview:webView];
    
    
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
