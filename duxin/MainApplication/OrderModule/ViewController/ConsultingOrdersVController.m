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
#import "ReservatingCell.h"

@interface ConsultingOrdersVController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderTitleView  *_titleView;
    UITableView *_tablView;
    NSMutableArray *_dataArray;
    BOOL _isHeaderRefresh;
    NSInteger _selectedIndex;
    NSInteger _page;
    NSString  *_pageCount;
    
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
            _selectedIndex = AllOrder;
            break;
        case 1:
            _selectedIndex = WatingForOrderPay;
            break;
        case 2:
            _selectedIndex = WatingForConsulting;
            break;
        case 4:
            _selectedIndex = WatingForComment;
        case 5:
            _selectedIndex = FinishComment;
        case 6:
            _selectedIndex = FinishOrderPay;
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
    if (orderStatus == AllOrder) {
        [dic setObject:@"" forKey:@"status"];
    }
    else{
        [dic setObject:[NSString stringWithFormat:@"%d",(int)orderStatus] forKey:@"status"];
    }
    [dic setObject:[NSString stringWithFormat:@"%d",(int)_page] forKey:@"page"];
    
    NSString *url = nil;
    if (orderStatus == AllOrder|| orderStatus == 0 || orderStatus == 4) {
        url = FetchConsultingOrders;
    }
    else
    {
        url = FetchConsultingSubOrders;
    }
    [httpsManager getServerAPI:url deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"code"] integerValue] == 200) {
                NSDictionary *dataDic = [dic objectForKey:@"data"];
                if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                    NSArray *itemArray =(NSArray *)[dataDic objectForKey:@"result"];
                    NSArray *modelArray = [OrderModel fetchOrderModels:itemArray];
                    _pageCount = [[dataDic objectForKey:@"_meta"] objectForKey:@"pageCount"];
                    if (modelArray.count != 0) {
                        if (_isHeaderRefresh) {
                            [_dataArray removeAllObjects];
                        }
                        [_dataArray addObjectsFromArray:[OrderModel fetchOrderModels:itemArray]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tablView reloadData];
                        _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                }
                else{
                    _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
                    [SVHUD showSuccessWithDelay:@"获取数据数据失败!" time:0.8];
                }
            }
            else if([[dic objectForKey:@"code"] integerValue] == 401){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
                    [SVHUD showSuccessWithDelay:@"获取数据数据失败!" time:0.8];
                });
            }
            else{ [SVProgressHUD dismiss];}
        });
        
    } fail:^(id error) {
        _isHeaderRefresh?[_tablView.mj_header endRefreshing]:[_tablView.mj_footer endRefreshing];
        [SVHUD showSuccessWithDelay:@"获取数据数据失败!" time:0.8];
    }];
    
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
    
    OrderModel *model = _dataArray[indexPath.section];
    static NSString *waitingForPayID = @"GeneralCellID";
    NSInteger orderStatus = [model.orderStatus integerValue];
    ReservatingCell *cell = [tableView dequeueReusableCellWithIdentifier:waitingForPayID];
    if (cell == nil) {
        cell = [[ReservatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitingForPayID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.section;
    [cell setCellStytle:orderStatus];
    [cell fetchData:model];
    cell.cancelBlock = ^(NSInteger tag) {
       // [self cancelAction:tag];
    };
    cell.generalBlock = ^(NSInteger tag) {
       // [self generalBlock:tag];
    };
    return cell;
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
