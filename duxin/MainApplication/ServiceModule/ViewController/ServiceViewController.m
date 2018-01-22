//
//  ServiceViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceViewController.h"
#import "CustomerServiceCell.h"
#import "MyCounselorVC.h"
#import "ChatViewController.h"
#import "ServiceBtn.h"

@interface ServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSArray *_headerDataArray;
    NSMutableArray *_erviceBtnArray;
}
@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.navView.middleBtn setTitle:@"服务" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];

    CGFloat tabbarBar = Height_TabBar;
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView)-tabbarBar) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self tableViewHeaderView];
    _tableView.backgroundView = [self tableViewBackView];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

-(UIView *)tableViewBackView{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, h(_tableView))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, h(backView)/2.5)];
    upView.backgroundColor = Color_EEEEEE;
    [backView addSubview:upView];
    
    return  backView;
    
}


-(void)initData{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _headerDataArray = @[@{@"image":@"cS",@"title":@"客服"},@{@"image":@"appointment",@"title":@"预约咨询师"},@{@"image":@"myLecture",@"title":@"我的咨询师"}];
    _erviceBtnArray =[[NSMutableArray alloc] initWithCapacity:0];
}

-(UIView *)tableViewHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SIZE.width,88)];
    view.backgroundColor = Color_EEEEEE;
    
    UIView *layerView = [[UIView alloc] initWithFrame:CGRectMake(7, 7,w(view)-14, h(view)-14)];
    layerView.backgroundColor = Color_F1F1F1;
    [layerView.layer setCornerRadius:2.0f];
    [view addSubview:layerView];
    
    [_headerDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        
        CGFloat pedding = 0.001f;
        
        CGFloat x = (w(layerView)-pedding)/3;
        CGFloat y = h(layerView)/2;
        
        ServiceBtn *btn = [[ServiceBtn alloc] initWithFrame:CGRectMake(0, 0,x,h(layerView))];
        btn.center = CGPointMake(0.5*x+x*idx,y);
        [btn setImage:dic[@"image"] setTitle:dic[@"title"]];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.tag = idx;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [layerView addSubview:btn];
        [_erviceBtnArray addObject:btn];
        
    }];
    
    

    return  view;
}

-(void)btnClick:(ServiceBtn *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            ChatViewController *vc =[[ChatViewController alloc] initWithConversationChatter:kDefaultCustomerName];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 1:
        {

            
        }
            break;
            
        case 2:
        {
            MyCounselorVC *vc  = [[MyCounselorVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    CustomerServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[CustomerServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell setDefaultStytle];
    return cell;
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
