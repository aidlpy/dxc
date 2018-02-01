//
//  ConsultingOrdersVController.m
//  duxin
//
//  Created by 37duxin on 22/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingOrdersVController.h"
#import "ReservationOrderVController.h"
#import "OrderTitleView.h"
#import "ConsultingOrdersCell.h"
#import "ConsultingMainModel.h"
#import "SubOrderModel.h"
#import "ViewCommentViewController.h"
#import "CommentViewController.h"

@interface ConsultingOrdersVController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderTitleView  *_titleView;
    UITableView *_tablView;
    NSMutableArray *_dataArray;
    BOOL _isHeaderRefresh;
    NSInteger _selectedIndex;
    NSInteger _page;
    NSString  *_pageCount;
    BOOL _isSubApi;
    
}
@end

@implementation ConsultingOrdersVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initData];
    [self initUI];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tablView.mj_header beginRefreshing];
}

-(void)initData{
     _page = 1;
    _isSubApi = NO;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"深度咨询" rightImage:@"whiteLeftArrow"];
    
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, 50) withArray:@[@"全部",@"待支付",@"待咨询",@"待评价",@"已评价",@"已完成"]];
    _titleView.indexBlock = ^(NSInteger index) {
         [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    _selectedIndex = AllOrder;
    _tablView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(_titleView), SIZE.width, SIZE.height-bottom(_titleView)) style:UITableViewStyleGrouped];
    _tablView.delegate = self;
    _tablView.dataSource = self;
    _tablView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isHeaderRefresh = YES;
        [self jugmentLastPage:_selectedIndex];
    }];
    _tablView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _isHeaderRefresh = NO;
        [self jugmentLastPage:_selectedIndex];
    }];
    _tablView.estimatedRowHeight = 0;
    _tablView.estimatedSectionHeaderHeight = 0;
    _tablView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tablView];

}


-(void)selectedIndex:(NSInteger)index
{
    _isHeaderRefresh = YES;
    switch (index) {
        case 0:
        {
            _isSubApi= false;
            _selectedIndex = AllOrder;
        }
            break;
        case 1:
        {
            _isSubApi= false;
            _selectedIndex = WatingForOrderPay;
            
        }
            break;
        case 2:
        {
            _isSubApi= YES;
            _selectedIndex = 0;
        }
            break;
        case 3:
        {
            _isSubApi= YES;
            _selectedIndex = 1;
        }
            break;
        case 4:
        {
            _isSubApi = YES;
            _selectedIndex = 2;
        }
            break;
        case 5:
        {
             _isSubApi= false;
            _selectedIndex = FinishComment;
        }
            break;
        case 6:
        {
            _isSubApi= false;
            _selectedIndex = FinishOrderPay;
        }
            break;
            
        default:
            break;
    }
    [_tablView.mj_header beginRefreshing];
    
}

-(void)jugmentLastPage:(NSInteger)orderStatus{
    
    if (_isHeaderRefresh) {
        _page = 1;
        [self getDataWithHeaderRefresh:orderStatus];
    }
    else{
        _page++;
    }
    
    if (_pageCount) {
        if (_page > [_pageCount integerValue]) {
            _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
        }
        else
        {
            [self getDataWithHeaderRefresh:orderStatus];
        }
    }
    
}

-(void)getDataWithHeaderRefresh:(NSInteger)orderStatus{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%d",(int)_page] forKey:@"page"];
    NSString *url = nil;
    if (_isSubApi == NO) {
         url = FetchConsultingOrders;
        if (orderStatus == AllOrder) {
            [dic setObject:@"" forKey:@"status"];
        }
        else
        {
            [dic setObject:[NSString stringWithFormat:@"%d",(int)orderStatus] forKey:@"status"];
        }
    }
    else
    {
        url = FetchConsultingSubOrders;
        [dic setObject:[NSString stringWithFormat:@"%d",(int)orderStatus] forKey:@"sub_status"];
    }
    
    [httpsManager getServerAPI:url deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"code"] integerValue] == 200) {
                NSDictionary *dataDic = [dic objectForKey:@"data"];
                if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                    NSArray *itemArray =(NSArray *)[dataDic objectForKey:@"result"];
                    _pageCount = [[dataDic objectForKey:@"_meta"] objectForKey:@"pageCount"];
                    if (itemArray.count != 0) {
                        
                        NSDictionary *dic = [itemArray objectAtIndex:0];
                        if ([dic objectForKey:@"status"] != nil) {
                          
                            [self fetchConsulationMainOrder:itemArray];
                        }
                        else
                        {
                         
                            
                            [self fetchConsulationSubOrder:itemArray];
                        }
                        
                    }
                    else
                    {
                        if (_isHeaderRefresh) {
                            [_dataArray removeAllObjects];
                            //  _tablView.backgroundView.backgroundColor = [UIColor redColor];
                        }
                    
                    }
               
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tablView reloadData];
                        _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                }
                else{
                    _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
                    [SVHUD showErrorWithDelay:@"获取数据数据失败!" time:0.8];
                }
            }
            else if([[dic objectForKey:@"code"] integerValue] == 401){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
                    [SVHUD showErrorWithDelay:@"获取数据数据失败!" time:0.8];
                });
            }
            else{ [SVProgressHUD dismiss];}
        });
        
    } fail:^(id error) {
        _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
        [SVHUD showErrorWithDelay:@"获取数据数据失败!" time:0.8];
    }];
    
}

//获取主订单的数组信息，然后转为主订单的model数组
-(void)fetchConsulationMainOrder:(NSArray *)itemArray {
    
    if (itemArray.count != 0) {
        
        NSArray *modelArray = [ConsultingMainModel fetchConsultingMainModels:itemArray];
        if (_isHeaderRefresh == YES) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:modelArray];
    }
    
    
}

//获取子订单的数组信息，然后转为主订单的model数组
-(void)fetchConsulationSubOrder:(NSArray *)itemArray{
    
    if (itemArray.count != 0) {
        
        NSArray *modelArray = [SubOrderModel fetchOrderSubModels:itemArray];
        if (_isHeaderRefresh == YES) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:modelArray];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001f;
    }else{
        return 7.0f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *revervationCell = @"RevervationCell";
        ConsultingOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:revervationCell];
        if (cell == nil) {
            cell = [[ConsultingOrdersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:revervationCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.section;
        id object = _dataArray[indexPath.section];
        if ([object isKindOfClass:[ConsultingMainModel class]]) {
            
            ConsultingMainModel *model = _dataArray[indexPath.section];
            NSInteger orderStatus = [model.orderStatus integerValue];
            [cell setConsultingOrdersCellStytle:orderStatus];
            [cell fetchMainData:model];
            cell.cancelBlock = ^(NSInteger tag) {
                [self cancelAction:tag];
            };
            cell.generalBlock = ^(NSInteger tag) {
                [self generalAction:tag];
            };
            
        }
        else
        {
            
            SubOrderModel *model = _dataArray[indexPath.section];
            NSInteger orderStatus = [model.orderSubStatus integerValue];
            [cell setConsultingSubOrderCell:orderStatus];
            [cell fetchSubData:model];
            cell.cancelBlock = ^(NSInteger tag) {
                nil;
            };
            cell.generalBlock = ^(NSInteger tag) {
                [self generalAction:tag];
            };
        }

        return cell;
}

-(void)cancelAction:(NSUInteger)tag{
    [AAlertView alert:self message:@"请确认是否取消订单?" confirm:^{
        [self cancelOrder:tag];
    } completion:^{
        nil;
    }];
}

//判断主订单和子订单的状态
-(void)generalAction:(NSUInteger)tag{
   
    if (_isSubApi == NO) {
        //主订单的状态
        ConsultingMainModel *model = _dataArray[tag];
        NSLog(@"orderStatus==>%@",model.orderStatus);
        switch ([model.orderStatus integerValue]) {
            case WatingForOrderPay:
            {
                
            
            }
                break;
            case 3:
            {
                [self viewComment:model.orderId];
            }
                break;
            case AlreadColse:
            {
            
                [AAlertView alert:self message:@"请确认是否删除订单?" confirm:^{
                    [self deleteOrder:tag];
                } completion:^{
                    nil;
                }];
                
            }
                break;
            
        default:
            break;
    }
        
    }
    else
    {
        //子订单的状态判断
        SubOrderModel *model = _dataArray[tag];
        switch ([model.orderSubStatus integerValue]) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                [self goToComment:model.orderId];
            }
                break;
            case 2:
            {
                [self viewComment:model.orderId];
            }
                break;
            default:
                break;
        }
    }
}


-(void)viewComment:(NSString *)orderId{
    
    ViewCommentViewController *vc = [[ViewCommentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.orderId = orderId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)goToComment:(NSString *)orderId{
    
    CommentViewController *vc =[[CommentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.orderId = orderId;
    vc.isMainOrder =YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)deleteOrder:(NSInteger)tag{
    ConsultingMainModel *model = _dataArray[tag];
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *deleteURL = [NSString stringWithFormat:@"%@%@",PostDeleteOrder,model.orderId];
    NSLog(@"deletdic==>%@",dic);
    [httpsManager postServerAPI:deleteURL deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([[dic objectForKey:@"code"] integerValue] == 200) {
                
                if ([[[dic objectForKey:@"data"] objectForKey:@"error_code"] integerValue] == 0) {
                    [_dataArray removeObjectAtIndex:tag];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tablView reloadData];
                        [SVHUD showSuccessWithDelay:@"删除订单成功！" time:0.8];
                    });
                }
                else{
                    [SVHUD showErrorWithDelay:@"删除订单失败!" time:0.8];
                }
            }
            else if([[dic objectForKey:@"code"] integerValue] == 401){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   [SVHUD showErrorWithDelay:@"删除订单失败!" time:0.8];
                });
            }
            else{ [SVProgressHUD dismiss];}
        });
        
    } fail:^(id error) {
       [SVHUD showErrorWithDelay:@"删除订单失败!" time:0.8];
    }];
}

-(void)cancelOrder:(NSUInteger)tag{
    
    ConsultingMainModel *model = _dataArray[tag];
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *cancelURL = [NSString stringWithFormat:@"%@%@",PostCancelOrder,model.orderId];
    [httpsManager postServerAPI:cancelURL deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([[dic objectForKey:@"code"] integerValue] == 200) {
                
                if ([[[dic objectForKey:@"data"] objectForKey:@"error_code"] integerValue] == 0) {
                    
                    if (_selectedIndex == AllOrder) {
                        model.orderStatus = @"5";
                    }
                    else{
                        [_dataArray removeObjectAtIndex:tag];
                    }
                  
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tablView reloadData];
                        [SVHUD showSuccessWithDelay:@"取消订单成功！" time:0.8];
                    });
                    
                }
                else
                {
                    [SVHUD showErrorWithDelay:@"取消订单失败！" time:0.8];
                }
                
            }
            else if([[dic objectForKey:@"code"] integerValue] == 401){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                  [SVHUD showErrorWithDelay:@"取消订单失败！" time:0.8];
                });
            }
            else{ [SVProgressHUD dismiss];}
        });
        
    } fail:^(id error) {
        [SVHUD showErrorWithDelay:@"取消订单失败！" time:0.8];
    }];
}



-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
