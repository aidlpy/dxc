//
//  RegisterViewController.m
//  duxin
//
//  Created by 37duxin on 20/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "RegisterViewController.h"
#import "DelegateViewController.h"
#import "LoginView.h"

@interface RegisterViewController ()
{
    UIButton *_registerBtn;
    NSArray *_dataArray;
    NSMutableArray *_loginViewArray;
    UIButton *_selectingBtn;
    UIButton *_delegateBtn;
    BOOL _isSeledted;
    
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initUI];
        });
    });
}

-(void)initData{
    _isSeledted = YES;
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
        if (idx == 0)
        {
            loginView.textField.keyboardType =UIKeyboardTypePhonePad;
        }
        else
        if (idx == 1)
        {
           loginView.textField.keyboardType =UIKeyboardTypeNumberPad;
        }
        else
        {
            loginView.textField.keyboardType = UIKeyboardTypeDefault;
        }
     
        if (idx == 1) {
            loginView.codeBtn.hidden = NO;
        }
        if (idx == 2) {
            loginView.textField.secureTextEntry = YES;
        }
        
        loginView.codeBlock = ^(JKCountDownButton *sender) {
            [self configBtn:sender];
        };

        [self.view addSubview:loginView];
        [_loginViewArray addObject:loginView];
        
    }];
    
    
    _selectingBtn = [[UIButton alloc] initWithFrame:CGRectMake(x(_loginViewArray.lastObject)+25, bottom(_loginViewArray.lastObject)+10, 15 , 15)];
    [_selectingBtn setImage:[UIImage imageNamed:Image(@"choice")] forState:UIControlStateNormal];
    [_selectingBtn addTarget:self action:@selector(clickChoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectingBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left(_selectingBtn)+10, 0,75, 11.5)];
    label.center = CGPointMake(label.center.x, _selectingBtn.center.y);
    label.text = @"已经阅读并同意";
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = Color_4C4C4C;
    [self.view addSubview:label];
    
    _delegateBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(label)-3,0, 45, 11.5)];
    _delegateBtn.center = CGPointMake(_delegateBtn.center.x, label.center.y+0.5f);
    _delegateBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [_delegateBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    [_delegateBtn setTitleColor:self.navView.backgroundColor forState:UIControlStateNormal];
    [_delegateBtn addTarget:self action:@selector(pushDelegate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_delegateBtn];
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, bottom(_loginViewArray.lastObject)+48,SIZE.width-70,40)];
    _registerBtn.backgroundColor = Color_5ECAF5;
    [_registerBtn.layer setCornerRadius:2.0f];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
}


-(void)pushDelegate:(UIButton *)sender{
    
    DelegateViewController *vc = [[DelegateViewController  alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)clickChoice{
    
    _isSeledted = !_isSeledted;
    [_selectingBtn setImage:[UIImage imageNamed:_isSeledted?Image(@"choice"):Image(@"default")] forState:UIControlStateNormal];
    
}

-(void)configBtn:(JKCountDownButton *)sender{
 NSString *mobileString  = ((LoginView *)(_loginViewArray[0])).textField.text;
    if ([mobileString isMobileNumber])
    {
        sender.enabled = NO;
        //button type要 设置成custom 否则会闪动
        [sender startWithSecond:60];
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            if (second == 59) {
                [self fetchCodeAction];
                [sender setTitleColor:Color_F1F1F1 forState:UIControlStateNormal];
            }
            NSString *title = [NSString stringWithFormat:@"%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            [sender setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
            return @"获取验证码";
        }];
        
    }
    else
    {
        [SVHUD  showErrorWithDelay:@"手机号码错误！" time:0.8f];
    }
}


-(void)registerAciton:(UIButton *)btn{
    if (_isSeledted == YES) {
        NSString *mobileString  = ((LoginView *)(_loginViewArray[0])).textField.text;
        NSString *codeString = ((LoginView *)(_loginViewArray[1])).textField.text;
        NSString *passwordString =((LoginView *)(_loginViewArray[2])).textField.text;
        
        if ([mobileString isMobileNumber]){
            
            if (codeString.length == 6) {
                
                if ([RegularTool matchPassword:passwordString])
                {
                    [self postRegister];
                }
                else
                {
                    [SVHUD showErrorWithDelay:@"密码错误!" time:0.8];
                }
            }
            else
            {
                [SVHUD showErrorWithDelay:@"验证码错误!" time:0.8];
            }
            
        }
        else
        {
            [SVHUD showErrorWithDelay:@"验证码错误!" time:0.8];
            
        }
    }
    else
    {
        [SVHUD showErrorWithDelay:@"请同意协议" time:0.8f];
    }
 

}

-(void)fetchCodeAction{
 
     NSString *mobileString = ((LoginView *)(_loginViewArray[0])).textField.text;
    if ([mobileString isMobileNumber]) {

        HttpsManager *httpsManager = [[HttpsManager alloc] init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:((LoginView *)(_loginViewArray[0])).textField.text forKey:@"username"];
        [dic setObject:@"application/json" forKey:@"Content-Type"];
        [httpsManager postServerAPI:PostMobileCode deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([[dic objectForKey:@"code"] integerValue] == 200)
            {
                NSDictionary *dataDic = [dic objectForKey:@"data"];
                if ([[dataDic objectForKey:@"error_code"] integerValue] ==0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVHUD showSuccessWithDelay:[dataDic objectForKey:@"msg"] time:0.8];
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                      [SVProgressHUD showErrorWithStatus:[dataDic objectForKey:@"msg"]];
                    });
                }
                
            }
            else
                if([[dic objectForKey:@"code"] integerValue] == 401){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:@"获取验证码失败！"];
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:@"获取验证码失败！"];
                    });
                }
            
            });
        
            } fail:^(id error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
            }];
        
        
        }
        else
        {
            [SVHUD showErrorWithDelay:@"手机号码错误!" time:0.8];
        
        }
    
}

-(void)postRegister{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:((LoginView *)(_loginViewArray[0])).textField.text forKey:@"username"];
    [dic setObject:((LoginView *)(_loginViewArray[2])).textField.text forKey:@"password"];
    [dic setObject:((LoginView *)(_loginViewArray[1])).textField.text forKey:@"code"];
    [dic setObject:FetchDeviceID forKey:@"device"];
    [httpsManager postServerAPI:PostRegister deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([[dic objectForKey:@"code"] integerValue] == 200)
            {
        
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVHUD showSuccessWithDelay:@"注册成功！" time:0.8f blockAction:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                });
                
            }
            else
            if([[dic objectForKey:@"code"] integerValue] == 401){
               
                dispatch_async(dispatch_get_main_queue(), ^{
                 [SVHUD showSuccessWithDelay:@"注册失败！" time:0.8];
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                  [SVHUD showSuccessWithDelay:@"注册失败！" time:0.8];
                });
            }
            
        });
        
    } fail:^(id error) {
            [SVHUD showSuccessWithDelay:@"注册失败！" time:0.8];
    }];
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
