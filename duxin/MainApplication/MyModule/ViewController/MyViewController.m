//
//  MyViewController.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyViewController.h"
#import "MyCell.h"
#import "MyHeaderBtn.h"
#import "MyCollectionVC.h"
#import "MyFoucsViewController.h"
#import "AccountSafeViewController.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
#import "MyDynamicViewController.h"
#import "ReservationOrderVController.h"
#import "ConsultingOrdersVController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    UIButton *_loginBtn;
    UIImageView *_genderImageView;
    UIButton *_loginBtnTitle;
    NSArray *_orderImageArray;
    
    
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

-(void)initData{
    _dataArray = @[@[@{@"headImage":@"myCollection",@"title":@"我的收藏"},@{@"headImage":@"myFoucs",@"title":@"我的关注"}],@[@{@"headImage":@"accountSecurity",@"title":@"账号与安全"}],@[@{@"headImage":@"aboutUs",@"title":@"关于我们"}]];
    _orderImageArray = @[@{@"image":@"reservationOrder",@"title":@"预约订单"},@{@"image":@"consultingOrders",@"title":@"咨询订单"},@{@"image":@"myTidings",@"title":@"我的动态"}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginUpdate:) name:LOGINUPDATE object:nil];
}

- (void)loginUpdate:(NSNotification *)notification{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadDataForTableViewHeader];
    });
    
}

-(void)login{

    
    if ([FetchLoginState isEqualToString:LOGINSUCCESS]) {
        
    }
    else{
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    
 
    
}

-(void)initUI{
    self.view.backgroundColor = Color_5ECAF5;
    //设置导航栏
    [self.navView setHidden:YES];
    
    CGFloat tabbarBar = Height_TabBar;
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SIZE.width, SIZE.height-tabbarBar) style:UITableViewStyleGrouped];
    _tableView.backgroundView = [self tableViewBackView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self tableViewHeader];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
}

-(UIView *)tableViewHeader{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 306)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, h(view))];
    [backImageView setImage:[UIImage imageNamed:Image(@"loginHeadBack")]];
    backImageView.userInteractionEnabled = YES;
    [view addSubview:backImageView];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 85, 85)];
    _loginBtn.center = CGPointMake(SIZE.width/2,170);
    [_loginBtn setBackgroundColor:Color_5DCBF5];
    [_loginBtn.layer setCornerRadius:w(_loginBtn)/2];
    [_loginBtn.layer setBorderWidth:2.0f];
    [_loginBtn.layer setBorderColor:Color_F1F1F1.CGColor];
    _loginBtn.clipsToBounds = YES;
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_loginBtn];
    
    _loginBtnTitle = [[UIButton alloc] initWithFrame:CGRectMake(0, bottom(_loginBtn)+15, 100, 20)];
    _loginBtnTitle.center = CGPointMake(SIZE.width/2, _loginBtnTitle.center.y);
    _loginBtnTitle.titleLabel.font = FONT_15;
    [_loginBtnTitle setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
    [view addSubview:_loginBtnTitle];
    
    _genderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_loginBtn)+15, 0, 15, 15)];
    _genderImageView.center = CGPointMake(_genderImageView.center.x, _loginBtnTitle.center.y);
    [view addSubview:_genderImageView];
    
    [self reloadDataForTableViewHeader];

    [_orderImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        
        MyHeaderBtn *btn = [[MyHeaderBtn alloc] initWithFrame:CGRectMake(SIZE.width*115/750+idx*SIZE.width*220/750, h(view)-48, 40, 40)];
        [btn setImage:dic[@"image"] setTitle:dic[@"title"]];
        [btn addTarget:self action:@selector(myHeadAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.clipsToBounds = YES;
        btn.tag = idx;
        [view addSubview:btn];
        
    }];
    
    return view;
}

-(void)reloadDataForTableViewHeader{
    
    
    if ([FetchLoginState isEqualToString:LOGINSUCCESS]) {
        
        if (FetchUserHeaderImage)
        {
             [_loginBtn sd_setImageWithURL:[NSURL URLWithString:FetchUserHeaderImage] forState:UIControlStateNormal];
        }
        else
        {
             [_loginBtn setImage:[UIImage imageNamed:Image(@"unLogin")] forState:UIControlStateNormal];
        }
        
        [_loginBtnTitle setTitle:FetchUserNickName forState:UIControlStateNormal];
        if (FetchUserSex) {
            switch ([FetchUserSex integerValue]) {
                case 0:
                {
                    _genderImageView.hidden = YES;
                }
                    break;
                    
                case 1:
                {
                     _genderImageView.hidden = NO;
                    [_genderImageView setImage:[UIImage imageNamed:Image(@"male")]];
                }
                    break;
                case 2:
                {
                     _genderImageView.hidden = NO;
                     [_genderImageView setImage:[UIImage imageNamed:Image(@"female")]];
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
      
        
    }
    else
    {
        [_loginBtn setImage:[UIImage imageNamed:Image(@"unLogin")] forState:UIControlStateNormal];
        [_loginBtnTitle setTitle:@"请登录" forState:UIControlStateNormal];
        _genderImageView.hidden = YES;
    }
    
}


-(void)myHeadAction:(MyHeaderBtn *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            ReservationOrderVController *vc = [ReservationOrderVController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            ConsultingOrdersVController *vc = [ConsultingOrdersVController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:
        {
            MyDynamicViewController *vc = [MyDynamicViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}



-(UIView *)tableViewBackView{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, h(_tableView))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, h(backView)/2.5)];
    upView.backgroundColor = Color_5ECAF5;
    [backView addSubview:upView];
    
    return  backView;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 8)];
    view.backgroundColor = Color_EEEEEE;
    return  view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 0.001)];
    view.backgroundColor = [UIColor whiteColor];
    return  view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = _dataArray[section];
    return sectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    NSDictionary *dic = _dataArray[indexPath.section][indexPath.row];
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    cell.titleLabel.text = dic[@"title"];
    [cell.imageView setImage:[UIImage imageNamed:Image(dic[@"headImage"])]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    MyCollectionVC *vc = [MyCollectionVC new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 1:
                {
                    MyFoucsViewController *vc = [MyFoucsViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            AccountSafeViewController *vc = [AccountSafeViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 2:
        {
            AboutUsViewController *vc = [AboutUsViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)dealloc{
    
    
    
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
