//
//  BaseViewController.m
//  mtm
//
//  Created by Albert on 18/01/2017.
//  Copyright © 2017 guest. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()
{
   
}
@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    _navView = [[CustomNavView alloc] init];
    _navView.backgroundColor = Color_5DCBF5;
    __block typeof(self) weakSelf = self;
    _navView.backBlock =^(){[weakSelf backTo];};
    _navView.pushBlock = ^(){[weakSelf nextTo];};
    [self.view addSubview:_navView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

//设置状态栏颜色
-(void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)nextTo{};
-(void)backTo{};

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
