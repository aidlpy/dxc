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
#import "ServiceBtn.h"
#import "ChatWithPaymentVC.h"
#import "EMFriendModel.h"
#import "CustomerServiceViewController.h"



@interface ServiceViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSArray *_headerDataArray;
    NSMutableArray *_erviceBtnArray;
}
@end

@implementation ServiceViewController

void fetchEMFriends(ServiceViewController *weakSelf){
    
    HttpsManager *httpsManager = [HttpsManager new];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [httpsManager getServerAPI:FetchEMFriends deliveryDic:dic successful:^(id responseObject) {
        NSLog(@"responseObject==>%@",responseObject);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"code"] integerValue] ==200) {
                NSArray *dicArray = [[dic objectForKey:@"data"] objectForKey:@"data"];
                NSArray *array = [EMFriendModel fetchFriendArray:dicArray];
                [weakSelf->_dataArray removeAllObjects];
                [weakSelf->_dataArray addObjectsFromArray:array];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf->_tableView reloadData];
                    [weakSelf->_tableView.mj_header endRefreshing];
                });
            }
            else{
                [weakSelf errorWanring];
            }
            
        });
    } fail:^(id error) {
         [weakSelf errorWanring];
    }];
}

-(void)author:(NSString *)cid fetchResult:(void(^)(BOOL result))resultBlock{
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic  = [[NSMutableDictionary alloc] init];
    [dic setObject:cid forKey:@"cid"];
    [httpsManager postServerAPI:FetchEMFriendsRelation deliveryDic:dic successful:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] ==200) {
            NSDictionary *dataDic = [dic objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] ==0) {
                NSDictionary *resultDic = [dataDic objectForKey:@"data"];
                NSNumber *status = [resultDic objectForKey:@"status"];
                
                if (status) {
                    BOOL isAutor = [status boolValue];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultBlock(isAutor);
                    });
                }
                else
                {
                    [self errorWanringOfRelation];
                    return;
                }
            }
        }
        else
        {
            [self errorWanringOfRelation];
            return;
        }
        
    } fail:^(id error) {
        [self errorWanringOfRelation];
        return;
    }];
}

-(void)messagesDidReceive:(NSArray *)aMessages{
    fetchEMFriends(self);
    
}

-(void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    fetchEMFriends(self);
}



-(void)errorWanring{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取环信好友失败" time:0.8];
        [_tableView.mj_header endRefreshing];
    });
    
}

-(void)errorWanringOfRelation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取环信好友失败" time:0.8];
        [_tableView.mj_header endRefreshing];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [_tableView.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
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
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          fetchEMFriends(self);
    }];
    _tableView.tableHeaderView = [self tableViewHeaderView];
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
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
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
            [self pushToSerViceRoom];
        }
            break;
            
        case 1:
        {
            [self pushToSerViceRoom];
            
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



-(void)pushToSerViceRoom{
    
    CacheChatReceiverAdvatar(CustomServiceAdvatar);
    CustomerServiceViewController *vc = [[CustomerServiceViewController alloc] initWithConversationChatter:EMCUSTOMERNUMBERT conversationType:EMConversationTypeChat];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
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
    EMFriendModel *model = _dataArray[indexPath.row];
    [cell updateUIModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [SVProgressHUD show];
    EMFriendModel *model = _dataArray[indexPath.row];
    if (indexPath.row == 0)
    {
        if (FetchToken != nil) {
            [[EMClient sharedClient] loginWithUsername:FetchEMUsername password:FetchEMPassword];
            model.unreadMessageCount = 0;
            CustomerServiceCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.unreadLabel.hidden = YES;
        }
        CacheChatReceiverAdvatar(model.emFriendsAvatar);
        ChatWithPaymentVC *vc = [[ChatWithPaymentVC alloc] initWithConversationChatter:model.emFriendsChatUserName conversationType:EMConversationTypeChat];
        vc.friendNickName =model.emFriendsNickname;
         vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
        [self author:model.emFriendID fetchResult:^(BOOL result) {
            if (result) {
                [SVProgressHUD dismiss];
                if (FetchToken != nil) {
                    [[EMClient sharedClient] loginWithUsername:FetchEMUsername password:FetchEMPassword];
                }
                CacheChatReceiverAdvatar(model.emFriendsAvatar);
                ChatWithPaymentVC *vc = [[ChatWithPaymentVC alloc] initWithConversationChatter:model.emFriendsChatUserName conversationType:EMConversationTypeChat];
                vc.friendNickName =model.emFriendsNickname;
                vc.hidesBottomBarWhenPushed = YES;
                if (vc) {
                    
                    model.unreadMessageCount = 0;
                    CustomerServiceCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                    cell.unreadLabel.hidden = YES;
                    
                    [SVProgressHUD dismiss];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [SVProgressHUD dismiss];
                    [SVHUD showErrorWithDelay:@"该用户未注册" time:0.8];
                }
                
            }
            else{
                
                [SVHUD showErrorWithDelay:@"关系不存在" time:0.8];
                
            }
        }];
        
        
    }
    
}

-(void)dealloc{
    
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
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
