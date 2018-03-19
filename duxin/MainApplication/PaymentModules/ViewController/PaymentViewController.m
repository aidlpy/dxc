//
//  PaymentViewController.m
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "PaymentViewController.h"
#import "UPPaymentControl.h"
#import "MainTabbarVC.h"
#import "ChatWithPaymentVC.h"
#import "PaySuccessfulViewController.h"
#import "UMSPPPayUnifyPayPlugin.h"

@interface PaymentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_cellArray;
    UILabel *_priceLabel;
    UILabel *_detailLabel;
    UIButton *_payBtn;
    NSString *_tnString;
    NSString *_orderType;
    NSInteger _selectedPayType;
    NSString *_orderNumber;
}
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}


-(void)initData{
    _selectedPayType = 0;
    _cellArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *dic0 = [[NSMutableDictionary  alloc]initWithObjectsAndKeys:@"weChatPay",@"image",@"微信支付",@"title",@"1",@"status",nil];
    NSMutableDictionary *dic1 = [[NSMutableDictionary  alloc]initWithObjectsAndKeys:@"aliPay",@"image",@"支付宝",@"title",@"0",@"status",nil];
    NSMutableDictionary *dic2 = [[NSMutableDictionary  alloc]initWithObjectsAndKeys:@"visaPay",@"image",@"银联支付",@"title",@"0",@"status",nil];
    [_cellArray addObject:dic0];
    [_cellArray addObject:dic1];
    [_cellArray addObject:dic2];
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"支付页面" rightImage:@"whiteLeftArrow"];
    
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, SIZE.height-h(self.navView)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self fetchTableHeaderView];
    _tableView.tableFooterView = [self fetchFooterView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

-(UIView *)fetchTableHeaderView{
    
    UIView *view = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,82)];
    view.backgroundColor = Color_F1F1F1;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 75)];
    headerView.backgroundColor = [UIColor whiteColor];
    [view addSubview:headerView];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,20,SIZE.width-21, 20)];
    _priceLabel.textColor =Color_57CAF7;
    _priceLabel.text = [NSString stringWithFormat:@"%@元",self.orderPrice];
    _priceLabel.font = [UIFont systemFontOfSize:18.0f];
    [headerView addSubview:_priceLabel];
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_priceLabel), bottom(_priceLabel)+4,w(_priceLabel), 20)];
    _detailLabel.textColor = Color_1F1F1F;
    _detailLabel.text = self.title;
    _detailLabel.font = [UIFont systemFontOfSize:12.0f];
    [headerView addSubview:_detailLabel];
    
    return view;
}

-(UIView *)fetchFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,146)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20,0,SIZE.width-40,40)];
    button.center = CGPointMake(button.center.x, view.center.y);
    [button.layer setCornerRadius:2.0f];
    [button setTitleColor:Color_FFFFFF forState:UIControlStateNormal];
    [button setBackgroundColor:Color_57CAF7];
    [button setTitle:@"去支付" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

-(void)toPayAction:(UIButton *)sender{
    
    switch (_selectedPayType) {
        case 0:
        {
            [self wechatPay];
        }
            break;
        case 1:
        {
            [self alipay];
        }
            break;
        case 2:
        {
            [self visaPayment];
        }
            break;
            
        default:
            break;
    }
}

-(void)wechatPay{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_orderId forKey:self.iSCreated?@"oid":@"package_id"];
    [dic setObject:@"0" forKey:self.iSCreated?@"payment_method":@"payment"];
    [httpsManager postServerAPI:self.iSCreated?PostForPaymentCode:FetchCreateOrderNumber deliveryDic:dic successful:^(id responseObject) {
        NSDictionary *dic =(NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] == 200) {
            
            NSDictionary *dataDic = [dic  objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                
                NSDictionary *resultDic = [dataDic objectForKey:@"result"];
                _tnString = [resultDic objectForKey:@"payKey"];
                NSNumber *orderType = [resultDic objectForKey:@"type"];
                _orderType = orderType.stringValue;
                _orderNumber = [resultDic objectForKey:@"merOrderId"];
                
                [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_WEIXIN payData:_tnString callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
                    NSLog(@"resultInfo==>%@",resultInfo);
                    if ([resultCode isEqualToString:@"1003"]) {
                        
                    }
                }];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    PaySuccessfulViewController *vc = [self paySuccessfullyPage:_orderNumber orderType:_orderType];
                    vc.hidesBottomBarWhenPushed = YES;
                    NSDictionary *dic = @{@"vc":vc,@"orderType":_orderType,@"orderId":_orderNumber};
                    
                   //通知增加支付过度页面
                    NSNotification *notifyAdd =[NSNotification notificationWithName:@"addPayPage" object:nil userInfo:dic];
                    [[NSNotificationCenter defaultCenter] postNotification:notifyAdd];
                    
                });
       
                
            }
        }
        else{
            [self errorWarning];
        }
        
        
    } fail:^(id error) {
        [self errorWarning];
    }];
    
}

-(void)alipay{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_orderId forKey:self.iSCreated?@"oid":@"package_id"];
    [dic setObject:@"1" forKey:self.iSCreated?@"payment_method":@"payment"];
    [httpsManager postServerAPI:self.iSCreated?PostForPaymentCode:FetchCreateOrderNumber deliveryDic:dic successful:^(id responseObject) {
        NSDictionary *dic =(NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] == 200)
        {
            
            NSDictionary *dataDic = [dic  objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                
                NSDictionary *resultDic = [dataDic objectForKey:@"result"];
                _tnString = [resultDic objectForKey:@"payKey"];
                NSNumber *orderType = [resultDic objectForKey:@"type"];
                _orderType = orderType.stringValue;
                _orderNumber = [resultDic objectForKey:@"merOrderId"];
            
                [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:_tnString callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
                    NSLog(@"resultInfo==>%@",resultInfo);
                    if ([resultCode isEqualToString:@"1003"]) {
                        
                    }
                }];


                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    PaySuccessfulViewController *vc = [self paySuccessfullyPage:_orderNumber orderType:_orderType];
                    vc.hidesBottomBarWhenPushed = YES;
                    NSDictionary *dic = @{@"vc":vc,@"orderType":_orderType,@"orderId":_orderNumber};
                    //通知增加支付过度页面
                    NSNotification *notifyAdd =[NSNotification notificationWithName:@"addPayPage" object:nil userInfo:dic];
                    [[NSNotificationCenter defaultCenter] postNotification:notifyAdd];
                    
                });
                
            }
        }
        else
        {
            [self errorWarning];
        }
        
        
    } fail:^(id error) {
        [self errorWarning];
    }];
}


-(void)visaPayment{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_orderId forKey:self.iSCreated?@"oid":@"package_id"];
    [dic setObject:@"2" forKey:self.iSCreated?@"payment_method":@"payment"];
    [httpsManager postServerAPI:self.iSCreated?PostForPaymentCode:FetchCreateOrderNumber deliveryDic:dic successful:^(id responseObject) {
        
        NSDictionary *dic =(NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] == 200) {
            
            NSDictionary *dataDic = [dic  objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                
                NSDictionary *resultDic = [dataDic objectForKey:@"result"];
                _tnString = [resultDic objectForKey:@"payKey"];
                NSNumber *orderType = [resultDic objectForKey:@"type"];
                _orderType = orderType.stringValue;
                _orderNumber = [resultDic objectForKey:@"merOrderId"];
                [[UPPaymentControl  defaultControl] startPay:_tnString fromScheme:@"duxinvisapay" mode:@"00" viewController:self];
            
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    PaySuccessfulViewController *vc = [self paySuccessfullyPage:_orderNumber orderType:_orderType];
                    vc.hidesBottomBarWhenPushed = YES;
                    NSDictionary *dic = @{@"vc":vc,@"orderType":_orderType,@"orderId":_orderNumber};
                    //通知增加支付过度页面
                    NSNotification *notifyAdd =[NSNotification notificationWithName:@"addPayPage" object:nil userInfo:dic];
                    [[NSNotificationCenter defaultCenter] postNotification:notifyAdd];
                  
                });

            }
        }
        else{
            [self errorWarning];
        }
        
        
    } fail:^(id error) {
        [self errorWarning];
    }];
    
}

-(PaySuccessfulViewController *)paySuccessfullyPage:(NSString *)orderNumber orderType:(NSString *)orderType {
    PaySuccessfulViewController *vc = [PaySuccessfulViewController new];
    vc.typeString = orderType;
    vc.orderNumber = orderNumber;
    return vc;
}

-(void)errorWarning{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取支付失败" time:0.8];
        [_tableView.mj_header endRefreshing];
    });

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *paycell = @"paycell";
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:paycell];
    if (cell == nil) {
        cell = [[PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:paycell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.section;
    NSDictionary *dic = _cellArray[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:Image([dic objectForKey:@"image"])]];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    NSInteger status = [[dic objectForKey:@"status"] integerValue];
    [cell.selectedImageView setImage:[UIImage imageNamed:status==0?Image(@"payUnselected"):Image(@"paySelected")]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_cellArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableDictionary *dic = (NSMutableDictionary *)obj;
        if (idx == indexPath.row) {
            _selectedPayType = indexPath.row;
            [dic setObject:@"1" forKey:@"status"];
        }
        else{
            [dic setObject:@"0" forKey:@"status"];
        }
  
        
    }];
    [_tableView reloadData];

    
}

-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addPayPage" object:nil];
    
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
