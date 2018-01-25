//
//  ReservationOrderVController.m
//  duxin
//
//  Created by 37duxin on 22/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservationOrderVController.h"
#import "OrderTitleView.h"
#import "WatingForPayCell.h"
#import "OrderModel.h"
#import "FinishPayCell.h"

@interface ReservationOrderVController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderTitleView  *_titleView;
    UIScrollView *_mainScrollView;
    UITableView *_tablView;
    NSMutableArray *_dataArray;
}
@end

@implementation ReservationOrderVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initUI];
}

-(void)initData{
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *array = @[@"0",@"1",@"0"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderModel *model = [OrderModel new];
        model.orderState = [obj intValue];
        [_dataArray addObject:model];
    }];
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"预约订单" rightImage:@"whiteLeftArrow"];
    
    
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, 50) withArray:@[@"全部",@"待支付",@"已支付"]];
    _titleView.indexBlock = ^(NSInteger index) {
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    _tablView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(_titleView), SIZE.width, SIZE.height-bottom(_titleView)) style:UITableViewStylePlain];
    _tablView.delegate = self;
    _tablView.dataSource = self;
    [self.view addSubview:_tablView];
    
}

-(void)selectedIndex:(NSInteger)index
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *model = _dataArray[indexPath.section];
    switch (model.orderState) {
        case 0:
            return 75.0f;
            break;
        case 1:
            return 100.0f;
            break;
            
        default:
            break;
    }
    
    return 75.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderModel *model = _dataArray[indexPath.section];
    static NSString *waitingForPayID = @"watingForPayID";
    static NSString *payedID = @"watingForPayID";
    
    if (model.orderState == 0) {
        
        WatingForPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitingForPayID];
        if (cell == nil) {
            cell = [[WatingForPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitingForPayID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        // [cell setDefaultStytle];
        return cell;
        
    }else if (model.orderState == 1){
        
        FinishPayCell *cell = [tableView dequeueReusableCellWithIdentifier:payedID];
        if (cell == nil) {
            cell = [[FinishPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payedID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        // [cell setDefaultStytle];
        return cell;
    
    }
    else
    {
        
        return nil;
    }
    

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
