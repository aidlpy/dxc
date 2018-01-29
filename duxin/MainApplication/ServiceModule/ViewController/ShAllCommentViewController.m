//
//  ShAllCommentViewController.m
//  duxin
//
//  Created by felix on 2018/1/29.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShAllCommentViewController.h"
#import "ShConsultantJudgeTableViewCell.h"
#import "ShConsultantCommentDetailModel.h"
#import "UILabel+SuggestSize.h"
#import "ShConsultantCommentModel.h"


#define SH_CONSULTEJUDGE_CELL @"ShConsultantJudgeTableViewCell"

@interface ShAllCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *commentTableView;
@property (strong, nonatomic) NSMutableArray *commentListArray;
@property (strong, nonatomic) ShConsultantCommentModel *commentModel;
@property (assign, nonatomic) NSInteger pageNum;




@end

@implementation ShAllCommentViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageNum = 1;
    self.commentListArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self setNavBar];
    [self createTableView];
    
}

-(void)setNavBar
{
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.navView.middleBtn setTitle:@"全部评价" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.navView.leftBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateNormal];
    self.navView.backBlock();
    [self.navView.middleBtn.titleLabel setFont:FONT_20];

}

-(void)createTableView
{
    //设置列表属性
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.commentTableView];
    [self.commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCommentsData:YES];
    }];
    self.commentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getCommentsData:NO];
    }];
    [self.commentTableView.mj_header beginRefreshing];
}

#pragma mark --UITabBarDelegate && UITableViewDataSource--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.commentListArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        ShConsultantJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SH_CONSULTEJUDGE_CELL];
        if (!cell) {
            cell = [[ShConsultantJudgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SH_CONSULTEJUDGE_CELL];
        }
        if (indexPath.row == 1) {
            cell.line.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        if ( indexPath.row < self.commentListArray.count) {
            ShConsultantCommentDetailModel *detailModel = self.commentListArray[indexPath.row];
            [cell reloadUI:detailModel];
        }
        //commentLabel  距左边 13 + 60 + 10 距右 30
        //cell 高度 13 + 60 + 10 + 40 + 10 + 20 + 10
        CGFloat cellHeight = 123;
        CGSize size = [cell.commentLabel suggestedSizeForWidth:SIZE.width - 113];
        if (size.height>=20) {
            [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, size.height + cellHeight)];
        }else{
            [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20 + cellHeight)];
        }
        return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        ShConsultantJudgeTableViewCell *cell = (ShConsultantJudgeTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark --get comment data--
#pragma mark --get consultant comment data--
-(void)getCommentsData:(BOOL)isHeader
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.strID forKey:@"id"];
    if (isHeader == YES) {
        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum] forKey:@"pageNum"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%zd",self.pageNum + 1] forKey:@"pageNum"];
    }
    [dic setObject:@"10" forKey:@"limit"];
    @weakify(self)
    [[LKProtocolNetworkEngine sharedInstance] protocolWithUrl:FetchConsultantComment
        requestDictionary:dic
         responseModelCls:[ShConsultantCommentModel class]
        completionHandler:^(LMModel *response,SHModel *responseC, NSError *error) {
            @normalize(self)
            if (response.code == 200 && responseC.error_code == 0) {
                
                NSLog(@"all comment result = %@",responseC.result);
                self.commentModel = responseC.result;
                [self.navView.middleBtn setTitle:[NSString stringWithFormat:@"全部评价(%zd)",self.commentModel.count] forState:UIControlStateNormal];

                if (isHeader == YES) {
                    self.commentListArray = [ShConsultantCommentDetailModel mj_objectArrayWithKeyValuesArray:self.commentModel.list];
                    [self.commentTableView.mj_footer resetNoMoreData];
                    [self.commentTableView.mj_header endRefreshing];

                }else{
                    NSArray *array = [ShConsultantCommentDetailModel mj_objectArrayWithKeyValuesArray:self.commentModel.list];
                        if (array.count > 0) {
                            self.pageNum ++;
                            [self.commentListArray addObjectsFromArray:array];
                            [self.commentTableView reloadData];
                            [self.commentTableView.mj_footer endRefreshing];
                        }
                        else{
                            [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
                        }
                }
                [self.commentTableView reloadData];
                
            }else{
                [self.commentTableView.mj_footer endRefreshing];

                [SVProgressHUD showErrorWithStatus:responseC.msg];
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
