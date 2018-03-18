//
//  MyFoucsViewController.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyFoucsViewController.h"
#import "MyfoucsCell.h"
#import "ConsultingModel.h"
#import "ShConsultantDetailInfoViewController.h"

@interface MyFoucsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation MyFoucsViewController

-(void)fetchData{
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [httpsManager getServerAPI:FetchMyConsultingList deliveryDic:dic successful:^(id responseObject) {

           dispatch_async(dispatch_get_global_queue(0, 0), ^{

               NSDictionary *dataDic = [(NSDictionary *)responseObject objectForKey:@"data"] ;
               NSDictionary *resultDic = [dataDic objectForKey:@"result"];
               if ([[dataDic objectForKey:@"error_code"]  integerValue] == 0) {

                   NSArray *dicArray =[resultDic objectForKey:@"list"];
                   NSArray *modelArray = [ConsultingModel fetchFoucsModel:dicArray];
                   [_dataArray removeAllObjects];
                   [_dataArray addObjectsFromArray:modelArray];
                   
                   if (_dataArray.count != 0) {

                       dispatch_async(dispatch_get_main_queue(), ^{
                           [_tableView reloadData];
                           [_tableView.mj_header endRefreshing];

                       });

                   }else{
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [_tableView.mj_header endRefreshing];
                       });
                     

                   }
               }
               else
               {
                   [self errorWarning:@"获取关注咨询师失败!"];
               }

           });


    } fail:^(id error) {
        [self errorWarning:@"获取关注咨询师失败!"];
    }];



}

-(void)errorWarning:(NSString *)errorString{
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
        [SVHUD showErrorWithDelay:errorString time:0.8f];
        
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];
    
}

-(void)initData{
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"我的关注" rightImage:@"whiteLeftArrow"];
    
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, SIZE.height-h(self.navView)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundView = [UIImageView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [self customView];
}

-(void)customView{
    //初始化一个emptyView
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:Image(@"nonData")
                                                             titleStr:@"无数据"
                                                            detailStr:@""
                                                          btnTitleStr:@""
                                                        btnClickBlock:^{}];
    //元素竖直方向的间距
    emptyView.contentViewY = 70.0f;
    emptyView.titleLabTextColor = Color_BABABA;
    emptyView.titleLabFont = FONT_13;
    //设置空内容占位图
    _tableView.ly_emptyView = emptyView;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ConsultingModel *model = _dataArray[indexPath.row];
    static NSString *myfoucsCellID = @"MyfoucsCell";
    MyfoucsCell *cell = [tableView dequeueReusableCellWithIdentifier:myfoucsCellID];
    if (cell == nil) {
        cell = [[MyfoucsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myfoucsCellID];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.titleLab.text = model.name;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConsultingModel *model = _dataArray[indexPath.row];
    ShConsultantDetailInfoViewController *vc = [ShConsultantDetailInfoViewController new];
    NSLog(@"%@",model.toUserid);
    vc.strID = [NSString stringWithFormat:@"%@",model.toUserid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
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
