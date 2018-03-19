//
//  ShConsultViewController.m
//  duxin
//
//  Created by felix on 2018/2/4.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShConsultViewController.h"
#import "ShConstultTableViewCell.h"
#import "ShCommonModel.h"
#import "ShConsultModel.h"
#import "OrderTitleView.h"
#import "ShConsultantDetailInfoViewController.h"

#define CELLHEIGTH_115 115
#define Sh_CONSULT_CELL @"ShConstultTableViewCell"

@interface ShConsultViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger pageNum;
//咨询师类型(0:情感,1:职场,2:亲子,3:性心理,4:人际关系,5:个人成长,6:情绪压力,7:解梦,8:星座占卜) 参数可多次传递，中括号一定要带上，否则不算数组
@property (strong, nonatomic) NSMutableArray *service_type;
@property (strong, nonatomic) ShCommonModel *commonModel;
@property (strong, nonatomic) OrderTitleView *titleView;
@property (assign, nonatomic) NSInteger totalCount;

@end

@implementation ShConsultViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pageNum = 1;
    self.totalCount = 1;
    self.service_type = [[NSMutableArray alloc] initWithObjects:@"", nil];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self createUI];
    
}

-(void)createUI
{
    [self.navView setBackStytle:@"咨询师" rightImage:@"whiteLeftArrow"];
    
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, 50) withArray:@[@"全部",@"情感",@"亲子",@"职场",@"健康",@"科普"]];
    _titleView.indexBlock = ^(NSInteger index) {
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    //设置列表属性
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerClass:[ShConstultTableViewCell class] forCellReuseIdentifier:Sh_CONSULT_CELL];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar + 50);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"暂无数据" detailStr:@""];
    self.tableView.ly_emptyView.contentViewY = 70;
    self.tableView.ly_emptyView.titleLabFont = FONT_13;
    self.tableView.ly_emptyView.titleLabTextColor = Color_BABABA;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum =1;
        [self getMagazineData:YES];

    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNum++;
        if (_pageNum > _totalCount)
        {
           [_tableView.mj_footer endRefreshing];
        }
        else
        {
            [self getMagazineData:NO];
            
        }
        
    }];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark --UITabBarDelegate && UITableViewDataSource--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShConstultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Sh_CONSULT_CELL];
    if (!cell) {
        cell = [[ShConstultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Sh_CONSULT_CELL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShConsultModel *model = self.dataArray [indexPath.row];
    [cell reloadUI:model];
    [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELLHEIGTH_115)];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShConstultTableViewCell *cell = (ShConstultTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShConsultModel *model = self.dataArray[indexPath.row];
    ShConsultantDetailInfoViewController *vc = [[ShConsultantDetailInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.strID = [NSString stringWithFormat:@"%ld",(long)model.cid];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ---title view --
-(void)selectedIndex:(NSInteger)index
{
//    咨询师类型(1:恋爱婚姻,2:职业发展,3:亲子教育,4:性心理,5:人际关系,6:个人成长,7:情绪压力,8:解梦,9:星座占卜) 参数可多次传递，中括号一定要带上，否则不算数组
    
    [self.service_type removeAllObjects];
    self.pageNum = 1;
    switch (index) {
        case 0:
        {//全部
            [self.service_type addObject:@""];
        }
            break;
        case 1:
        {//情感
            [self.service_type addObject:@"1"];
        }
            break;
        case 2:
        {//亲子
            [self.service_type addObject:@"3"];
        }
            break;
        case 3:
        {//职场
            [self.service_type addObject:@"2"];
            [self.service_type addObject:@"5"];

        }
            break;
        case 4:
        {//健康
            [self.service_type addObject:@"4"];
            [self.service_type addObject:@"6"];
            [self.service_type addObject:@"7"];

        }
            break;
        case 5:
        {//星座
            [self.service_type addObject:@"8"];
            [self.service_type addObject:@"9"];

        }
            break;
            
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark --get collect data--
-(void)getMagazineData:(BOOL)isHeader
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_pageNum] forKey:@"page"];
    [dic setObject:@"10" forKey:@"pageSize"];
    __block NSString *strUrl = FetchConsultant;
    [self.service_type enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *endStr = [NSString stringWithFormat:@"&service_type[]=%@",obj];
        strUrl = [NSString stringWithFormat:@"%@%@",strUrl,endStr];
    }];
    HttpsManager *manager = [[HttpsManager alloc] init];
    [manager getServerAPI:strUrl deliveryDic:dic successful:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"code"] integerValue] == CODE_STATUS_SUCCESS ) {
            NSMutableArray *arrResultArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSDictionary *dicData =responseObject[@"data"];
            NSDictionary *dicMeta =dicData[@"_meta"];
            self.totalCount =[dicMeta[@"pageCount"] integerValue];
            if ([dicData[@"error_code"] integerValue] == 0) {
                NSMutableArray *arrResult =[[NSMutableArray alloc] initWithCapacity:0];
                arrResult = dicData[@"result"];
                [arrResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic = obj;
                    ShConsultModel *model = [[ShConsultModel alloc] init];
                    model.advisory_style = [self isNullCheck:dic[@"advisory_style"]];
                    model.amount = [[self isNullCheck:dic[@"amount"]] floatValue];
                    model.area = [self isNullCheck:dic[@"area"]];
                    model.cid = [[self isNullCheck:dic[@"cid"]] integerValue];
                    model.city = [self isNullCheck:dic[@"city"]];
                    model.cumulative_time = [self isNullCheck:dic[@"cumulative_time"]];
                    model.education_cert = [self isNullCheck:dic[@"education_cert"]];
                    model.education_type = [[self isNullCheck:dic[@"education_type"]] integerValue];
                    model.expertise_good = [self isNullCheck:dic[@"expertise_good"]];
      
                    model.freeze = [dic[@"freeze"] floatValue];
                    model.id =[[self isNullCheck:dic[@"id"]] integerValue];
                    model.introduction = [self isNullCheck:dic[@"introduction"]];
                    model.name = [self isNullCheck:dic[@"name"]];
                    model.passport_no = [self isNullCheck:dic[@"passport_no"]];
                    model.passport_opposite = [self isNullCheck:dic[@"passport_opposite"]];
                    model.passport_positive = [self isNullCheck:dic[@"passport_positive"]];
                    model.passport_type =[[self isNullCheck:dic[@"passport_type"]]  integerValue];
                    model.professional_background =[self isNullCheck:dic[@"professional_background"]];
                    model.province = [self isNullCheck:dic[@"province"]];
                    model.qualified_cert = [self isNullCheck:dic[@"qualified_cert"]];
                    model.qualified_name = [[self isNullCheck:dic[@"qualified_name"]]  integerValue];
                    model.qualified_no = [self isNullCheck:dic[@"qualified_no"]];
                    model.service_type =[self isNullCheck: dic[@"service_type"]];
                    model.tags = [self isNullCheck:dic[@"tags"]];
                    model.trained_background = [self isNullCheck:dic[@"trained_background"]];
                    
                    ShUserModel *userModel = [[ShUserModel alloc] init];
                    NSDictionary *dicUser =dic[@"user"];
                    userModel.avatar = [self isNullCheck:dicUser[@"avatar"]];
                    
                    userModel.device = [[self isNullCheck:dicUser[@"device"]] integerValue];
                    userModel.nickname = [self isNullCheck:dicUser[@"nickname"]];
                    userModel.id = [[self isNullCheck:dicUser[@"id"]] integerValue];
                    model.user = userModel;
                    
                   [arrResultArray addObject:model];
                }];
                
                
                if (isHeader == YES) {
                    [self.dataArray removeAllObjects];
                    self.dataArray = [NSMutableArray arrayWithArray:arrResultArray];
                    [self.tableView.mj_footer resetNoMoreData];
                    [self.tableView.mj_header endRefreshing];

                }
                else{

                    if (arrResult.count > 0) {
    
                        [self.dataArray addObjectsFromArray:arrResultArray];
                        [self.tableView reloadData];
                        [self.tableView.mj_footer endRefreshing];
                    }
                    else{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [self.tableView reloadData];
            }
            
        }
        else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:self.commonModel.msg];
        }
        
    } fail:^(id error) {
        
    }];

}

-(NSString *)isNullCheck:(id)class{
    NSString *string;
    if ([class isKindOfClass:[NSNull class]] || class == nil || class == NULL) {
        string = @"";
    }else{
          string = (NSString *)class;
    }
     return  string;
}




-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
};

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
