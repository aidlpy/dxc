//
//  MyCounselorVC.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyCounselorVC.h"
#import "MyConselorCell.h"
#import "CounselorDetailVC.h"
#import "ShConsultantDetailInfoViewController.h"
#import "ShConsultAttentionModel.h"
#import "ShConsultantInfoModel.h"
#import "ShConsultAttentionInfoModel.h"

@interface MyCounselorVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
}
@property (strong, nonatomic) ShConsultAttentionModel *attentionModel;
@property (strong, nonatomic) NSMutableArray *attentionArray;

@end

@implementation MyCounselorVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.attentionArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self createUI];
    [self getAttentionInfoData];
    
}

-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"我的咨询师" rightImage:@"whiteLeftArrow"];
    
    CGFloat tabbarBar = Height_TabBar;
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView)-tabbarBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = Color_FFFFFF;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getAttentionInfoData];
    }];
}
#pragma mark --get attention info data--
-(void)getAttentionInfoData
{
    @weakify(self)
    [[LKProtocolNetworkEngine sharedInstance] protocolWithUrl:FetchConsultantMyFollow
            requestDictionary:nil
             responseModelCls:[ShConsultAttentionModel class]
            completionHandler:^(LMModel *response,SHModel *responseC, NSError *error) {
                @normalize(self)
                if (response.code == 200 && responseC.error_code == 0) {
                    
                    self.attentionModel = responseC.result;
                    self.attentionArray = [ShConsultAttentionInfoModel mj_objectArrayWithKeyValuesArray:self.attentionModel.list];
                    [_tableView reloadData];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:responseC.msg];
                }
            }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.attentionArray.count;
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
    ShConsultantInfoModel *infoModel = self.attentionArray[indexPath.row];
    [cell reloadUI:infoModel];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShConsultantDetailInfoViewController *consultantInfoVC = [[ShConsultantDetailInfoViewController alloc] init];
    consultantInfoVC.hidesBottomBarWhenPushed = YES ;
    consultantInfoVC.strID = @"3";
    [self.navigationController pushViewController:consultantInfoVC animated:YES];
    
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
