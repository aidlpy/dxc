//
//  CounselorViewController.m
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CounselorViewController.h"
#import "OrderTitleView.h"
#import "CounselorCell.h"


@interface CounselorViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderTitleView *_titleView;
    UITableView *_tableView;
    
}
@end

@implementation CounselorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    
    
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"咨询师" rightImage:@"whiteLeftArrow"];
    
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, 50) withArray:@[@"全部",@"情感",@"亲子",@"职场",@"健康",@"星座"]];
    _titleView.indexBlock = ^(NSInteger index) {
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(_titleView), SIZE.width, SIZE.height-bottom(_titleView)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

-(void)selectedIndex:(NSInteger)index{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *counselorCellID = @"CounselorCellID";
    CounselorCell *cell = [tableView dequeueReusableCellWithIdentifier:counselorCellID];
    if (cell == nil) {
        cell = [[CounselorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:counselorCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.section;

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
