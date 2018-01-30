//
//  ShCredentialsCertifyViewController.m
//  duxin
//
//  Created by felix on 2018/1/30.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShCredentialsCertifyViewController.h"

@interface ShCredentialsCertifyViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIImageView *imageCertify;
@property (strong, nonatomic) UILabel *labelGuarantee;
@property (strong, nonatomic) UILabel *labelRefund;
@property (strong, nonatomic) UIButton *phoneNumBtn;
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation ShCredentialsCertifyViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    [self createUI];
}

-(void)createNav
{
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.navView.middleBtn setTitle:[NSString stringWithFormat:@"%@-资质认证",self.strName] forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.leftBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateNormal];
    [self.navView.rightBtn setImage:[UIImage imageNamed:Image(@"consultantShare")] forState:UIControlStateNormal];
    self.navView.backBlock();
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
}

-(void)createUI
{
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    self.scrollView.contentSize = CGSizeMake(SIZE.width ,SIZE.height +100);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.titleArray = @[@"资质认证",@"交易担保",@"不满意100%退款"];
    self.imageArray = @[[UIImage imageNamed:Image(@"consultantQualify")],[UIImage imageNamed:Image(@"consultantGuarantee")],[UIImage imageNamed:Image(@"consultantRefund")]];
    
    UIView *viewCertify = [[UIView alloc] init];
    viewCertify.frame = CGRectMake(10, 10, SIZE.width - 20, 200);
    viewCertify.layer.cornerRadius = 2;
    viewCertify.clipsToBounds = YES;
    viewCertify.layer.borderColor = Color_EEEEEE.CGColor;
    viewCertify.layer.borderWidth = 0.5;
    [self.scrollView addSubview:viewCertify];
//    [viewCertify mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo(200);
//    }];
    
   
    UIButton *btnCertify =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnCertify setTitle:self.titleArray[0] forState:UIControlStateNormal];
    [btnCertify setImage:self.imageArray[0] forState:UIControlStateNormal];
    [btnCertify setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
    btnCertify.titleLabel.font = FONT_15;
    [btnCertify layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [viewCertify addSubview:btnCertify];
    [btnCertify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(4);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    self.imageCertify = [[UIImageView alloc] init];
    [self.imageCertify sd_setImageWithURL:[NSURL URLWithString:self.strURL] placeholderImage:[UIImage imageNamed:Image(@"")]];
    self.imageCertify.backgroundColor = Color_EEEEEE;
    [viewCertify addSubview:self.imageCertify];
    [self.imageCertify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.top.equalTo(btnCertify.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-15);
    }];
    
    
    UIView *viewGuarantee = [[UIView alloc] init];
    viewGuarantee.layer.cornerRadius = 2;
    viewGuarantee.clipsToBounds = YES;
    viewGuarantee.layer.borderColor = Color_EEEEEE.CGColor;
    viewGuarantee.layer.borderWidth = 0.5;
    [self.scrollView addSubview:viewGuarantee];
    [viewGuarantee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewCertify.mas_left);
        make.top.equalTo(viewCertify.mas_bottom).offset(15);
        make.right.equalTo(viewCertify.mas_right);
        make.height.mas_equalTo(100);
    }];
    
    
    
    UIButton *btnGuarantee =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnGuarantee setTitle:self.titleArray[1] forState:UIControlStateNormal];
    [btnGuarantee setImage:self.imageArray[1] forState:UIControlStateNormal];
    [btnGuarantee setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
    btnGuarantee.titleLabel.font = FONT_15;
    [btnGuarantee layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [viewGuarantee addSubview:btnGuarantee];
    [btnGuarantee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(4);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    self.labelGuarantee = [[UILabel alloc] init];
    self.labelGuarantee.text = @"交易资金平台监督，若专家违约，由37度心给予现金赔付，保障每一位用户权益";
    self.labelGuarantee.font = FONT_13;
    self.labelGuarantee.textColor = Color_1F1F1F;
    self.labelGuarantee.numberOfLines = 0;
    self.labelGuarantee.lineBreakMode = UILineBreakModeWordWrap;
    [viewGuarantee addSubview:self.labelGuarantee];
    [self.labelGuarantee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.top.equalTo(btnGuarantee.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-12);
    }];
    
    
    UIView *viewRefund = [[UIView alloc] init];
    viewRefund.layer.cornerRadius = 2;
    viewRefund.clipsToBounds = YES;
    viewRefund.layer.borderColor = Color_EEEEEE.CGColor;
    viewRefund.layer.borderWidth = 0.5;
    [self.scrollView addSubview:viewRefund];
    [viewRefund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewCertify.mas_left);
        make.top.equalTo(viewGuarantee.mas_bottom).offset(15);
        make.right.equalTo(viewCertify.mas_right);
        make.height.mas_equalTo(100);
    }];
    
    UIButton *btnRefund =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRefund setTitle:self.titleArray[2] forState:UIControlStateNormal];
    [btnRefund setImage:self.imageArray[2] forState:UIControlStateNormal];
    [btnRefund setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
    btnRefund.titleLabel.font = FONT_15;
    [btnRefund layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [viewRefund addSubview:btnRefund];
    [btnRefund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(30);
    }];
    
    self.labelRefund = [[UILabel alloc] init];
    self.labelRefund.text = @"交易资金平台监督，若专家违约，由37度心给予现金赔付，保障每一位用户权益";
    self.labelRefund.font = FONT_13;
    self.labelRefund.textColor = Color_1F1F1F;
    self.labelRefund.numberOfLines = 0;
    self.labelRefund.lineBreakMode = UILineBreakModeWordWrap;
    [viewRefund addSubview:self.labelRefund];
    [self.labelRefund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.top.equalTo(btnRefund.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-12);
    }];
  
    
    UILabel *canLabel= [[UILabel alloc] init];
    canLabel.text = @"如有任何问题，可拨打客服电话";
    canLabel.font = FONT_13;
    canLabel.textColor = Color_1F1F1F;
    canLabel.numberOfLines = 0;
    canLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.scrollView addSubview:canLabel];
    [canLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.right.mas_equalTo(-45);
        make.top.equalTo(viewRefund.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    self.phoneNumBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.phoneNumBtn setTitle:@"400-123-1234" forState:UIControlStateNormal];
    [self.phoneNumBtn setTitleColor:Color_5DCBF5 forState:UIControlStateNormal];
    self.phoneNumBtn.titleLabel.font = FONT_13;
    [self.phoneNumBtn addTarget:self action:@selector(phoneNumBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.phoneNumBtn];
    [self.phoneNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(canLabel.mas_left);
        make.top.equalTo(canLabel.mas_bottom);
        make.height.mas_equalTo(canLabel.mas_height);
    }];
    
    self.timeLabel= [[UILabel alloc] init];
    self.timeLabel.text = @"早8:00 - 凌晨2:00";
    self.timeLabel.font = FONT_13;
    self.timeLabel.textColor = Color_1F1F1F;
    [self.scrollView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumBtn.mas_right).offset(5);
        make.right.mas_equalTo(-20);
        make.top.equalTo(self.phoneNumBtn.mas_top);
        make.height.mas_equalTo(self.phoneNumBtn.mas_height);
    }];

    UILabel *serviceLabel= [[UILabel alloc] init];
    serviceLabel.text = @"或联系在线客服";
    serviceLabel.font = FONT_13;
    serviceLabel.textColor = Color_1F1F1F;
    [self.scrollView addSubview:serviceLabel];
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(canLabel.mas_left);
        make.right.mas_equalTo(-55);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.height.mas_equalTo(canLabel.mas_height);
    }];
    
}
//拨打电话
-(void)phoneNumBtnClick
{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-123-1234"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
 
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
