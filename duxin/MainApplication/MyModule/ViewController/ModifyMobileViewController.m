//
//  ModifyMobileViewController.m
//  duxin
//
//  Created by 37duxin on 31/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ModifyMobileViewController.h"
#import "LoginView.h"

@interface ModifyMobileViewController ()
{

    NSArray *_dataArray;
    NSMutableArray *_loginViewArray;
    UIButton *_saveBtn;
}
@end

@implementation ModifyMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    
    _dataArray = @[@{@"logo":@"mobileLogo",@"placeHolder":@"请输入手机号"},@{@"logo":@"codeLogo",@"placeHolder":@"请输入手机验证码"}];
    _loginViewArray = [[NSMutableArray alloc] initWithCapacity:0];

}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"账号与安全" rightImage:@"whiteLeftArrow"];
    
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        CGFloat viewHeight = 50.0f;
        CGFloat pedding = 8.5f;
        LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, h(self.navView)+pedding+idx*viewHeight, SIZE.width, viewHeight)];
        [loginView setLogoImageView:dic[@"logo"] setPlaceHolder:dic[@"placeHolder"]];
        if (idx == 0) {
            loginView.textField.keyboardType = UIKeyboardTypePhonePad;
        }
        if (idx == 1) {
            loginView.codeBtn.hidden  = NO;
        }
        loginView.codeBlock = ^(JKCountDownButton *sender) {[self fetchCodeAction];};
        [self.view addSubview:loginView];
        [_loginViewArray addObject:loginView];
        
    }];
    
    _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, bottom(_loginViewArray.lastObject)+48,SIZE.width-70,40)];
    _saveBtn.backgroundColor = Color_5ECAF5;
    [_saveBtn.layer setCornerRadius:2.0f];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(changeMoileNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
}


-(void)fetchCodeAction{
    
    NSString *mobileString = ((LoginView *)(_loginViewArray[0])).textField.text;
    if ([RegularTool isPhoneNumber:mobileString]) {
        
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


-(void)changeMoileNumber{
    
        NSString *mobileString  = ((LoginView *)(_loginViewArray[0])).textField.text;
        NSString *codeString = ((LoginView *)(_loginViewArray[1])).textField.text;

        if ([RegularTool isPhoneNumber:mobileString]){
            
            if (codeString.length == 6) {
                
                [self postModifyMobileNumber];
            }
            else
            {
                [SVHUD showErrorWithDelay:@"验证码错误!" time:0.8];
            }
            
        }
        else
        {
            [SVHUD showErrorWithDelay:@"手机号码错误！" time:0.8];
            
        }
    
}

-(void)postModifyMobileNumber{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:((LoginView *)(_loginViewArray[0])).textField.text forKey:@"username"];
    [dic setObject:((LoginView *)(_loginViewArray[1])).textField.text forKey:@"code"];
    [httpsManager postServerAPI:PostModifyMobileNumber deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([[dic objectForKey:@"code"] integerValue] == 200)
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVHUD showSuccessWithDelay:@"修改手机成功！" time:0.8];
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
            else
                if([[dic objectForKey:@"code"] integerValue] == 401){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVHUD showSuccessWithDelay:@"修改手机失败！" time:0.8];
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVHUD showSuccessWithDelay:@"修改手机失败！" time:0.8];
                    });
                }
            
        });
        
    } fail:^(id error) {
        [SVHUD showSuccessWithDelay:@"修改手机失败！" time:0.8];
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
