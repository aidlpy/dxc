//
//  AccountSafeViewController.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AccountSafeViewController.h"
#import "AccountSafeCell.h"

@interface AccountSafeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSArray *_dataArray;
    
}

@end

@implementation AccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}


-(void)initData{
    _dataArray = @[@{@"title":@"手机号"},@{@"title":@"邮箱"},@{@"title":@"微信"},@{@"title":@"QQ"}];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"账号安全" rightImage:@"whiteLeftArrow"];
    
    CGFloat tabbarBar = Height_TabBar;
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, SIZE.height-tabbarBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 53.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    NSDictionary *dic = _dataArray[indexPath.row];
    AccountSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[AccountSafeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    cell.titleLab.text = dic[@"title"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
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
