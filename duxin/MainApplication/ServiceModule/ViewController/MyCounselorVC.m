////
////  MyCounselorVC.m
////  duxin
////
////  Created by 37duxin on 19/01/2018.
////  Copyright © 2018 37duxin. All rights reserved.
////
//
#import "MyCounselorVC.h"
#import "MyConselorCell.h"
#import "CounselorDetailVC.h"
#import "CustomerServiceModel.h"
#import "ShConsultantDetailInfoViewController.h"


@interface MyCounselorVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BOOL _isHeaderFresh;
    NSString *_totalNumber;
    NSInteger _pageNumber;

}
@end

@implementation MyCounselorVC


void fetchCounselorList(MyCounselorVC *weakSelf){
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [httpsManager getServerAPI:FetchConsultingList deliveryDic:dic successful:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            if([[dataDic objectForKey:@"code"] integerValue] ==200){

                if ([[[dataDic objectForKey:@"data"] objectForKey:@"error_code"] integerValue] == 0) {

                    NSArray  *resultArray =[[dataDic objectForKey:@"data"] objectForKey:@"result"];
                    weakSelf->_totalNumber = [[[dataDic objectForKey:@"data"] objectForKey:@"_meta"] objectForKey:@"totalCount"];
                    if (weakSelf->_isHeaderFresh) {
                        [weakSelf->_dataArray removeAllObjects];
                    }
                    if (resultArray.count == 0) {
                        
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                            weakSelf->_isHeaderFresh == YES ?[weakSelf->_tableView.mj_header endRefreshing]:[weakSelf->_tableView.mj_footer endRefreshing];
                          });

                        
                    }
                    else{
                        [CustomerServiceModel fetchModelsFromArray:resultArray fetchModel:^(BOOL stop,CustomerServiceModel *model) {
                            
                            [weakSelf->_dataArray addObject:model];
                            if (stop == YES ) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [weakSelf->_tableView reloadData];
                                    NSLog(@"weakSelf->_isHeaderFresh==>%d",weakSelf->_isHeaderFresh);
                                    weakSelf->_isHeaderFresh == YES ?[weakSelf->_tableView.mj_header endRefreshing]:[weakSelf->_tableView.mj_footer endRefreshing];
                                });
                            }
                        }];
                        
                        
                        
                    }
                

                }
                else
                {
                    [weakSelf errorWarning];
                }
            }
            else
            {
                [weakSelf errorWarning];
            }
        });

    } fail:^(id error) {
        [weakSelf errorWarning];
    }];
}

-(void)errorWarning{

    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取咨询师列表失败!" time:0.8f];
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the sview.
    [self initData];
    [self initUI];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];

}

-(void)initData{
    _isHeaderFresh = YES;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)initUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"我的咨询师" rightImage:@"whiteLeftArrow"];

    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = Color_FFFFFF;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isHeaderFresh = YES;
        fetchCounselorList(self);
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _isHeaderFresh = NO;
        if (!_totalNumber || _pageNumber >[_totalNumber integerValue]) {
            fetchCounselorList(self);
        }
        else
        {
            [self->_tableView.mj_footer endRefreshing];
        }
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.5f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    MyConselorCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[MyConselorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell setDefaultStytleWithData:_dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerServiceModel *model = _dataArray[indexPath.row];
    ShConsultantDetailInfoViewController *consultantInfoVC = [[ShConsultantDetailInfoViewController alloc] init];
    consultantInfoVC.strID = model.consultantProfileCID;
    consultantInfoVC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:consultantInfoVC animated:YES];

}


-(void)backTo{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
//
//  MyCounselorVC.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

//#import "MyCounselorVC.h"
//#import "MyConselorCell.h"
//#import "CounselorDetailVC.h"
//#import "ShConsultantDetailInfoViewController.h"
//#import "ShConsultAttentionModel.h"
//#import "ShConsultantInfoModel.h"
//#import "ShConsultAttentionInfoModel.h"
//
//@interface MyCounselorVC ()<UITableViewDelegate,UITableViewDataSource>
//{
//    UITableView *_tableView;
//
//}
//@property (strong, nonatomic) ShConsultAttentionModel *attentionModel;
//@property (strong, nonatomic) NSMutableArray *attentionArray;
//
//@end
//
//@implementation MyCounselorVC
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.attentionArray = [[NSMutableArray alloc] initWithCapacity:0];
//    [self createUI];
//    [self getAttentionInfoData];
//
//}
//
//-(void)createUI{
//
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navView setBackStytle:@"我的咨询师" rightImage:@"whiteLeftArrow"];
//
//    CGFloat tabbarBar = Height_TabBar;
//    //设置列表属性
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView)-tabbarBar) style:UITableViewStylePlain];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor = Color_FFFFFF;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    [self.view addSubview:_tableView];
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [self getAttentionInfoData];
//    }];
//}
//#pragma mark --get attention info data--
//-(void)getAttentionInfoData
//{
//    @weakify(self)
//    [[LKProtocolNetworkEngine sharedInstance] protocolWithUrl:FetchConsultantMyFollow
//                                            requestDictionary:nil
//                                             responseModelCls:[ShConsultAttentionModel class]
//                                            completionHandler:^(LMModel *response,SHModel *responseC, NSError *error) {
//                                                @normalize(self)
//
//                                                NSLog(@"responseC=>%@",responseC);
//                                                if (response.code == 200 && responseC.error_code == 0) {
//
//                                                    self.attentionModel = responseC.result;
//                                                    self.attentionArray = [ShConsultAttentionInfoModel mj_objectArrayWithKeyValuesArray:self.attentionModel.list];
//                                                    [_tableView reloadData];
//
//                                                }else{
//                                                    [SVHUD showErrorWithDelay:responseC.msg time:0.8];
//                                                }
//                                            }];
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.attentionArray.count;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 72.5f;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *MyIdentifier = @"MyIdentifier";
//    MyConselorCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//    if (cell == nil) {
//        cell = [[MyConselorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
//        ;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.tag = indexPath.row;
//    ShConsultantInfoModel *infoModel = self.attentionArray[indexPath.row];
//    [cell reloadUI:infoModel];
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ShConsultAttentionInfoModel *infoModel = self.attentionArray[indexPath.row];
//    ShConsultantDetailInfoViewController *consultantInfoVC = [[ShConsultantDetailInfoViewController alloc] init];
//    consultantInfoVC.hidesBottomBarWhenPushed = YES ;
//    consultantInfoVC.strID = [NSString stringWithFormat:@"%zd",infoModel.to_user_id];
//    [self.navigationController pushViewController:consultantInfoVC animated:YES];
//
//}


//-(void)backTo{
//
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//@end


