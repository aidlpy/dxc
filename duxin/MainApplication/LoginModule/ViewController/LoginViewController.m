//
//  LoginViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FogotPsViewController.h"
#import "LoginView.h"

@interface LoginViewController ()
{
    UIImageView *_userImageView;
    UIImageView *_passwordImageV;
    UIButton *_loginBtn;
    UIButton *_registerBtn;
    UIButton *_forgotpsBtn;
    NSArray *_dataArray;
    NSMutableArray *_loginViewArray;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initData];
    });
    [self initUI];
}

-(void)initData{
    
    _dataArray = @[@{@"logo":@"mobileLogo",@"placeHolder":@"请输入手机号"},@{@"logo":@"passwordLogo",@"placeHolder":@"请输入密码"}];
    _loginViewArray = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView.backgroundColor = Color_5ECAF5;
    self.navView.leftBtn.frame = CGRectMake(10, Height_StatusBar+5, 40, 40);
    [self.navView.leftBtn setImage:[UIImage imageNamed:Image(@"close")] forState:UIControlStateNormal];
    [self.navView.middleBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
    
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        CGFloat viewHeight = 50.0f;
        CGFloat pedding = 8.5f;
        LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, h(self.navView)+pedding+idx*viewHeight, SIZE.width, viewHeight)];
        [loginView setLogoImageView:dic[@"logo"] setPlaceHolder:dic[@"placeHolder"]];
        loginView.codeBlock = ^{nil;};
        [self.view addSubview:loginView];
        [_loginViewArray addObject:loginView];
        
    }];
    
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, bottom(_loginViewArray.lastObject)+48,SIZE.width-70,40)];
    _loginBtn.backgroundColor = Color_5ECAF5;
    [_loginBtn.layer setCornerRadius:2.0f];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,bottom(_loginBtn)+13,25,10)];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:Color_5ECAF5 forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _forgotpsBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-90,bottom(_loginBtn)+13,60,10)];
    [_forgotpsBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotpsBtn setTitleColor:Color_F54A5F forState:UIControlStateNormal];
    _forgotpsBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [_forgotpsBtn addTarget:self action:@selector(fogotPsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotpsBtn];
    
}

-(void)loginAciton:(UIButton *)loginBtn{
    [self postUser];
}

-(void)registerAction:(UIButton *)btn{
    
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)fogotPsAction:(UIButton *)btn{
    
    FogotPsViewController *vc = [[FogotPsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)postUser{
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"password" forKey:@"grant_type"];
    [dic setValue:((LoginView *)(_loginViewArray[0])).textField.text forKey:@"username"];
    [dic setValue:((LoginView *)(_loginViewArray[1])).textField.text forKey:@"password"];
    [dic setValue:@"testclient" forKey:@"client_id"];
    [dic setValue:@"testpass" forKey:@"client_secret"];
    [dic setValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    [httpsManager postServerAPI:FetchLogin deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"result==>%@",responseObject);
            });
            
        });
        
    } fail:^(id error) {
        NSLog(@"error==>%@",error);
    }];
    
    
}

-(void)backTo{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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