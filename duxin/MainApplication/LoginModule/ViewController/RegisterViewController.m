//
//  RegisterViewController.m
//  duxin
//
//  Created by 37duxin on 20/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginView.h"

@interface RegisterViewController ()
{
    UIButton *_registerBtn;
    NSArray *_dataArray;
    NSMutableArray *_loginViewArray;
    
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initData];
    });
    [self initUI];
}

-(void)initData{

    _dataArray = @[@{@"logo":@"mobileLogo",@"placeHolder":@"请输入手机号"},@{@"logo":@"codeLogo",@"placeHolder":@"请输入验证码"},@{@"logo":@"passwordLogo",@"placeHolder":@"请输入密码"}];
    _loginViewArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"注册" rightImage:@"whiteLeftArrow"];
    
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        CGFloat viewHeight = 50.0f;
        CGFloat pedding = 8.5f;
        
        LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, h(self.navView)+pedding+idx*viewHeight, SIZE.width, viewHeight)];
        [loginView setLogoImageView:dic[@"logo"] setPlaceHolder:dic[@"placeHolder"]];
        if (idx == 1) {
            loginView.codeBtn.hidden = NO;
        }
        loginView.codeBlock = ^{
            [self fetchCodeAction];
        };
        [self.view addSubview:loginView];
        [_loginViewArray addObject:loginView];
        
    }];
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, bottom(_loginViewArray.lastObject)+48,SIZE.width-70,40)];
    _registerBtn.backgroundColor = Color_5ECAF5;
    [_registerBtn.layer setCornerRadius:2.0f];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
}

-(void)fetchCodeAction{
    
    
    
}

-(void)registerAciton:(UIButton *)btn{
    
    
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
