//
//  PaySuccessfulViewController.m
//  duxin
//
//  Created by 37duxin on 04/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "PaySuccessfulViewController.h"
#import "ChatWithPaymentVC.h"
#import "MainTabbarVC.h"

@interface PaySuccessfulViewController ()
{
    UIImageView *_imageView;
    UILabel *_label;
    UIButton *_button;
}
@end

@implementation PaySuccessfulViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePayment:) name:INFOPAYMENT object:nil];

}

-(void)updatePayment:(NSNotification *)notification{
    NSDictionary *dic = [notification  userInfo];
    if ([dic[@"type"] isEqualToString:@"0"])
    {
        [_imageView setImage:[UIImage imageNamed:Image(@"fail")]];
        _label.text = @"支付失败";
        
    }
    else
    {
        [_imageView setImage:[UIImage imageNamed:Image(@"paySuccessfully")]];
        _label.text = @"支付成功";
    }
    
    
    
}


-(void)initUI{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessfully:) name:PAYSUCCESSFUL object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"支付" rightImage:@"whiteLeftArrow"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(7.5,h(self.navView)+7.5,SIZE.width-15, 150)];
    [view.layer setCornerRadius:2.0f];
    [view.layer setBorderColor:Color_F1F1F1.CGColor];
    [view.layer setBorderWidth:1.0f];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,60, 60)];
    _imageView.center = CGPointMake(self.view.center.x-10, 60);
    [_imageView.layer setCornerRadius:2.0f];
    [_imageView setImage:[UIImage imageNamed:Image(@"ic_wait")]];
    [view addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0,bottom(_imageView)+15, 100, 20)];
    _label.center = CGPointMake(self.view.center.x-10, _label.center.y);
    _label.text = @"支付等待中";
    _label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_label];
    [self.view addSubview:view];
    

   _button = [[UIButton alloc] initWithFrame:CGRectMake(35,bottom(view)+35, SIZE.width-70,40)];
    _button.backgroundColor = Color_57CAF7;
    [_button setTitle:@"完成" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    _button.hidden = YES;
    [self.view addSubview:_button];

}

-(void)paySuccessfully:(NSNotification *)notification{
    
    
    NSDictionary *dic = [notification userInfo];
    if ([dic[@"type"] isEqualToString:@"0"]) {
        _label.text = @"支付失败";
        [_imageView setImage:[UIImage imageNamed:Image(@"fail")]];
        _imageView.hidden = NO;
    }
    else{
        
        NSString *payType = [dic objectForKey:@"payType"];
        [self paySuccessful:payType];
        
    }

}



-(void)paySuccessful:(NSString *)type{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_orderNumber forKey:@"tn"];
    [dic setObject:type forKey:@"payment_method"];
    [httpsManager getServerAPI:FetchPaymentSuccessdfully deliveryDic:dic successful:^(id responseObject) {
        
        NSDictionary *responsDic = (NSDictionary *)responseObject;
        if ([[responsDic objectForKey:@"code"] integerValue] == 200) {
            NSDictionary *dataDic = [responsDic objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] == 0)
            {
                
                _label.text = @"支付完成";
                [_imageView setImage:[UIImage imageNamed:Image(@"paySuccessfully")]];
                _imageView.hidden = NO;
                _button.hidden = NO;
                
                NSDictionary *resultDic = [dataDic objectForKey:@"result"];
                NSMutableDictionary  *resultMutabledic = [resultDic mutableCopy];
                [dic setObject:self forKey:@"vc"];
                NSNotification *notifyEMLogin =[NSNotification notificationWithName:@"paySuccessful" object:nil userInfo:[resultMutabledic copy]];
                [[NSNotificationCenter defaultCenter] postNotification:notifyEMLogin];
               
            }
            else
            {
                _label.text = @"支付失败";
                [_imageView setImage:[UIImage imageNamed:Image(@"fail")]];
                _imageView.hidden = YES;
             
            }
        }
        else
        {
       
            [self warningPay];
            
        }
        
        
    } fail:^(id error) {
        [self warningPay];
    }];
    
    
}

-(void)warningPay{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取支付信息错误!" time:0.8];
        
    });
    
}



-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)finishAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    
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
