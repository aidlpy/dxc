//
//  ServiceDetailViewController.m
//  duxin
//
//  Created by 37duxin on 03/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "ServiceDetailCell.h"
#import "ServiceDetailModel.h"
#import "PaymentViewController.h"

@interface ServiceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIImageView *_headerImageView;
    UILabel *_titleLabel;
    UILabel *_subLabel;
    UIButton *_downLeftBtn;

    
}
@end

@implementation ServiceDetailViewController

-(void)fetchData{
    
    HttpsManager *httpsManager= [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@",FetchPackageBSingle,_idString];
    [httpsManager getServerAPI:url deliveryDic:dic successful:^(id responseObject) {
        
        NSDictionary *responDic = (NSDictionary *)responseObject;
        NSDictionary *dataDic = [responDic objectForKey:@"data"];
        if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
            
            NSDictionary *dic = [dataDic objectForKey:@"result"];
            [ServiceDetailModel dic:dic model:^(ServiceDetailModel *model) {
                    _titleLabel.text = model.servieTitle;
                    _subLabel.text = [NSString stringWithFormat:@"%@次",model.serviceTimes];
                    [_downLeftBtn setTitle:[NSString stringWithFormat:@"%@/次",model.serviceSinglePrice] forState:UIControlStateNormal];
                    if (_dataArray.count>0) {
                        [_dataArray removeAllObjects];
                    }
                
                    [_dataArray addObject:model];
                    [_tableView reloadData];
                    [_tableView.mj_header endRefreshing];
            }];
            
        }
        else{
            
            [self viewwarnning];
            
        }
       
    } fail:^(id error) {
        [self viewwarnning];
    }];

    
}

-(void)viewwarnning{
    
     dispatch_async(dispatch_get_main_queue(), ^{
         [SVHUD showErrorWithDelay:@"获取信息失败" time:0.8];
     });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

-(void)initData{
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)initUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"服务详情" rightImage:@"whiteLeftArrow"];
    
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView)-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self fetchTableViewHeader];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = Color_FFFFFF;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
    UIView *view = [self fetchFooterView];
    [self.view addSubview:view];
    
    
}

-(UIView *)fetchFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SIZE.height-50, SIZE.width, 50)];
    view.backgroundColor = Color_F1F1F1;
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-150, 1, 150, 49)];
    rightBtn.backgroundColor = Color_57CAF7;
    [rightBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(createOrder:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    
    
    _downLeftBtn= [[UIButton alloc] initWithFrame:CGRectMake(0,1,SIZE.width-w(rightBtn), h(view))];
    _downLeftBtn.backgroundColor = [UIColor whiteColor];
    _downLeftBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_downLeftBtn setTitleColor:Color_57CAF7 forState:UIControlStateNormal];
    [view addSubview:_downLeftBtn];
    

    return view;
    
}

-(void)createOrder:(UIButton *)sender{
    
    
    ServiceDetailModel *model = _dataArray[0];
    PaymentViewController *vc = [[PaymentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = model.servieTitle;
    vc.orderId = _idString;
    vc.orderPrice = model.serviceSinglePrice;
    vc.iSCreated = NO;
    [self.navigationController pushViewController:vc animated:YES];
}


-(UIView *)fetchTableViewHeader{
    
    UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,85)];
    view.backgroundColor = Color_F1F1F1;
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,77)];
    headerView.backgroundColor = [UIColor whiteColor];
    [view addSubview:headerView];
    

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,20,SIZE.width-80, 20)];
    _titleLabel.textColor =Color_1F1F1F;
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [headerView addSubview:_titleLabel];
    
    _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,bottom(_titleLabel), SIZE.width-80,20)];
    _subLabel.textColor = _titleLabel.textColor;
    _subLabel.font = [UIFont systemFontOfSize:13.0f];
    [headerView addSubview:_subLabel];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ServiceDetailModel *model = _dataArray[indexPath.row];
    return model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    ServiceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[ServiceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell updateUI:_dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


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
