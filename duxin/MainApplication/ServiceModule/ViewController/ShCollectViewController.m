//
//  ShCollectViewController.m
//  duxin
//
//  Created by felix on 2018/1/31.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShCollectViewController.h"
#import "ShCollectTableViewCell.h"
#import "ShCollectModel.h"
#import "ShCollectDetailModel.h"

#define HEIGHT_135 135
#define SH_COLLECT_CELL @"ShCollectTableViewCell"

@interface ShCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *collectTableView;
@property (strong, nonatomic) NSMutableArray *collectArray;
@property (assign, nonatomic) CGFloat pageNum;
@property (strong, nonatomic) ShCollectModel *collectModel;

@end

@implementation ShCollectViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 1;
    self.collectArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self setNavBar];
    [self createUI];
    
}

-(void)setNavBar
{
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.navView.middleBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.leftBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
}

-(void)createUI
{
    //设置列表属性
    self.collectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.collectTableView.delegate = self;
    self.collectTableView.dataSource = self;
    self.collectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectTableView.separatorColor = [UIColor clearColor];
    [self.collectTableView registerClass:[ShCollectTableViewCell class] forCellReuseIdentifier:SH_COLLECT_CELL];
    [self.view addSubview:self.collectTableView];
    [self.collectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.collectTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:Image(@"unCollect") titleStr:@"还没有收藏哦" detailStr:@""];
    self.collectTableView.ly_emptyView.contentViewY = 70;
    self.collectTableView.ly_emptyView.titleLabFont = FONT_13;
    self.collectTableView.ly_emptyView.titleLabTextColor = Color_BABABA;

    self.collectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCollectData:YES];
    }];
    self.collectTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getCollectData:NO];
    }];
    [self.collectTableView.mj_header beginRefreshing];
}

#pragma mark --UITabBarDelegate && UITableViewDataSource--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collectArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SH_COLLECT_CELL];
    if (!cell) {
        cell = [[ShCollectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SH_COLLECT_CELL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShCollectDetailModel *model = self.collectArray[indexPath.row];
    [cell reloadUI:model];
    [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_135)];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShCollectTableViewCell *cell = (ShCollectTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark --get collect data--
-(void)getCollectData:(BOOL)isHeader
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (isHeader == YES) {
        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum] forKey:@"pageNum"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum + 1] forKey:@"pageNum"];
    }
    [dic setObject:@"10" forKey:@"limit"];
    @weakify(self)
    [[ShProtocolNetworkEngine sharedInstance] protocolWithRequestMethod:REQUEST_METHOD_POST
             requestUrl:FetchMyCollection
           requestModel:dic
       responseModelCls:[ShCollectModel class]
      completionHandler:^(LMModel *response, NSError *error) {
          
          if (response.code == CODE_STATUS_SUCCESS) {
              @normalize(self)
              self.collectModel = response.data;
              if (self.collectModel.error_code == ERRORCODE_STATUS_SUCCESS)
              {
                  if (isHeader == YES) {
                      self.collectArray = [ShCollectDetailModel mj_objectArrayWithKeyValuesArray:self.collectModel.result];
                      [self.collectTableView.mj_footer resetNoMoreData];
                      [self.collectTableView.mj_header endRefreshing];

                  }else{
                      NSArray *array = [ShCollectDetailModel mj_objectArrayWithKeyValuesArray:self.collectModel.result];
                      if (array.count > 0) {
                          self.pageNum ++;
                          [self.collectArray addObjectsFromArray:array];
                          [self.collectTableView reloadData];
                          [self.collectTableView.mj_footer endRefreshing];
                      }
                      else{
                          [self.collectTableView.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  [self.collectTableView reloadData];
              
              }else{
                  [self.collectTableView.mj_header endRefreshing];
                  [self.collectTableView.mj_footer endRefreshing];
                  [SVProgressHUD showErrorWithStatus:self.collectModel.msg];
              }
          }
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
