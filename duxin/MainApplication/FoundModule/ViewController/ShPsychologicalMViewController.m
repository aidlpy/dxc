//
//  ShPsychologicalMViewController.m
//  duxin
//
//  Created by felix on 2018/2/4.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShPsychologicalMViewController.h"
#import "ArictleDetailViewController.h"
#import "ShCollectTableViewCell.h"
#import "ShCommonModel.h"
#import "ShArticalModel.h"
#import "OrderTitleView.h"


#define HEIGHT_135 135
#define SH_COLLECT_CELL @"ShCollectTableViewCell"


@interface ShPsychologicalMViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger pageNum;
@property (strong, nonatomic) ShCommonModel *commonModel;
@property (strong, nonatomic) OrderTitleView *titleView;
//杂志类型(0:情感,1:亲子,2:职场,3:健康,4:科普)
@property (assign, nonatomic) NSString *strType;
@property(nonatomic,assign)NSInteger totallyPage;





@end

@implementation ShPsychologicalMViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.totallyPage =1;
    self.strType= @"";
    self.pageNum = 1;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self createUI];
    
}


-(void)createUI
{

    [self.navView setBackStytle:@"心理杂志" rightImage:@"whiteLeftArrow"];
    
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
    [self.tableView registerClass:[ShCollectTableViewCell class] forCellReuseIdentifier:SH_COLLECT_CELL];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar + 50);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:Image(@"unCollect") titleStr:@"还没有收藏哦" detailStr:@""];
    self.tableView.ly_emptyView.contentViewY = 70;
    self.tableView.ly_emptyView.titleLabFont = FONT_13;
    self.tableView.ly_emptyView.titleLabTextColor = Color_BABABA;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self getMagazineData1:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNum++;
        [self getMagazineData1:NO];
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
    
    ShCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SH_COLLECT_CELL];
    if (!cell) {
        cell = [[ShCollectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SH_COLLECT_CELL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShArticalModel *model = self.dataArray[indexPath.row];
    [cell reloadUIWithArtical:model];
    [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_135)];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShCollectTableViewCell *cell = (ShCollectTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShArticalModel *model = self.dataArray[indexPath.row];
    ArictleDetailViewController *vc =[ArictleDetailViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.urlString = [NSString stringWithFormat:@"%@%@",@"https://h5.37du.xin/detail?id=",[NSString stringWithFormat:@"%ld",(long)model.id]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ---title view --
-(void)selectedIndex:(NSInteger)index
{
    self.pageNum =1;
    switch (index) {
        case 0:
        {
            self.strType = @"";
        }
            break;
        case 1:
        {
            self.strType = @"0";

        }
            break;
        case 2:
        {
            self.strType = @"1";

        }
            break;
        case 3:
        {
            self.strType = @"2";

        }
            break;
        case 4:
        {
            self.strType = @"3";
            
        }
            break;
        case 5:
        {
            self.strType = @"4";

        }
            break;
            
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)getMagazineData1:(BOOL)isHeader{
    
    if (_pageNum > _totallyPage) {
        isHeader?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
    }
    else
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum] forKey:@"page        "];
        [dic setObject:@"user" forKey:@"expand"];
        [dic setObject:@"10" forKey:@"pageSize"];
        [dic setObject:self.strType forKey:@"type"];
        [dic setObject:@"2" forKey:@"followRead"];
        [dic setObject:@"1" forKey:@"followTime"];
        
        HttpsManager *httpManager = [[HttpsManager alloc] init];
        [httpManager getServerAPI:FetchMagazine deliveryDic:dic successful:^(id responseObject) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{

                 if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
                     if ([[[responseObject objectForKey:@"data"] objectForKey:@"error_code"] integerValue] == 0) {
                         _totallyPage = [[[[responseObject objectForKey:@"data"]  objectForKey:@"_meta"] objectForKey:@"pageCount"] integerValue];
                         if (isHeader) {
                             [self.dataArray removeAllObjects];
                             NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
                             [ShArticalModel fetchData:array block:^(BOOL stop, ShArticalModel *model) {
                                 [self.dataArray addObject:model];
                                 if (stop) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [_tableView reloadData];
                                         [_tableView.mj_header endRefreshing];
                                     });
                                 }
                             }];
                           
                         }
                         else{
                             
                             NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
                             [ShArticalModel fetchData:array block:^(BOOL stop, ShArticalModel *model) {
                                 [self.dataArray addObject:model];
                                 if (stop) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [_tableView reloadData];
                                         [_tableView.mj_footer endRefreshing];
                                     });
                                 }
                             }];
                         
                         }
                         
                     }
                 }
        
            });
            
        } fail:^(id error) {
            
        }];

    }
    
}

#pragma mark --get collect data--
-(void)getMagazineData:(BOOL)isHeader
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (isHeader == YES) {
        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum] forKey:@"page"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum + 1] forKey:@"page"];
    }

    [dic setObject:@"user" forKey:@"expand"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:self.strType forKey:@"type"];
    [dic setObject:@"2" forKey:@"followRead"];
    [dic setObject:@"1" forKey:@"followTime"];

    
    @weakify(self)
    [[ShProtocolNetworkEngine sharedInstance] protocolWithRequestMethod:REQUEST_METHOD_GET
             requestUrl:FetchMagazine
           requestModel:dic
       responseModelCls:[ShCommonModel class]
      completionHandler:^(LMModel *response, NSError *error) {
          
          if (response.code == CODE_STATUS_SUCCESS) {
              @normalize(self)
              self.commonModel = response.data;
              if (self.commonModel.error_code == ERRORCODE_STATUS_SUCCESS)
              {
                  if (isHeader == YES) {
                      [self.dataArray removeAllObjects];
                      self.dataArray = [ShArticalModel mj_objectArrayWithKeyValuesArray:self.commonModel.result];
                      [self.tableView.mj_footer resetNoMoreData];
                      [self.tableView.mj_header endRefreshing];

                  }else{
                      NSArray *array = [ShArticalModel mj_objectArrayWithKeyValuesArray:self.commonModel.result];
                      if (array.count > 0) {
                          self.pageNum ++;
                          [self.dataArray addObjectsFromArray:array];
                          [self.tableView reloadData];
                          [self.tableView.mj_footer endRefreshing];
                      }
                      else{
                          [self.tableView.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  [self.tableView reloadData];
                  
              }else{
                  [self.tableView.mj_header endRefreshing];
                  [self.tableView.mj_footer endRefreshing];
                  [SVProgressHUD showErrorWithStatus:self.commonModel.msg];
              }
          }
      }];
    
}

-(void)fetchData{
    
    
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
