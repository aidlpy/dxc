//
//  ChatWithPaymentVC.m
//  duxin
//
//  Created by 37duxin on 25/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ChatWithPaymentVC.h"

@interface ChatWithPaymentVC ()

@end

@implementation ChatWithPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
 
}

-(void)initUI{
    
    self.title = @"1111";
    [self _setupBarButtonItem];
    
    
}

- (void)_setupBarButtonItem
{
    [UINavigationBar appearance].translucent = NO;
    self.navigationController.navigationBar.barTintColor = Color_5ECAF5;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self customStaus];
    
    UIButton *rightCallBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 19)];
    [rightCallBtn setImage:[UIImage imageNamed:Image(@"mobileCall")] forState:UIControlStateNormal];
    [rightCallBtn addTarget:self action:@selector(callMobileAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightCallBtn];
    UIBarButtonItem *rightNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNagetiveSpacer.width = -5;
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 19)];
    [leftBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *leftNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNagetiveSpacer.width = -5;
    
    self.navigationItem.rightBarButtonItems = @[rightNagetiveSpacer,rightBtnItem];
    self.navigationItem.leftBarButtonItems = @[leftNagetiveSpacer,leftBtnItem];
}

-(void)customStaus{
    
    CGFloat statusHeight = Height_StatusBar;
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0,0 - statusHeight,SIZE.width,statusHeight)];
    statusBarView.backgroundColor = Color_5ECAF5;
    [self.navigationController.navigationBar addSubview:statusBarView];
    
}

-(void)backAction:(UIButton *)btn{
    
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
