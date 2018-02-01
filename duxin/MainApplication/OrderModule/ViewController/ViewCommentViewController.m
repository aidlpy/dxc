//
//  ViewCommentViewController.m
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ViewCommentViewController.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "CommentFooter.h"

@interface ViewCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
}
@end

@implementation ViewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self initUI];
}

-(void)initData{
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"查看评论" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(self.navView), SIZE.width, SIZE.height-bottom(self.navView)) style:UITableViewStyleGrouped];
    _tableView.backgroundView = [[UIImageView alloc] initWithFrame:_tableView.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];

    [_tableView.mj_header beginRefreshing];
    
}


-(void)fetchData
{
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",FetchOrderComments,_orderId];
    [httpsManager getServerAPI:urlString deliveryDic:dic successful:^(id responseObject) {
       
          dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            if ([[responseObject objectForKey:@"code"] integerValue] ==200) {
                
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                NSArray *commentArray = [dataDic objectForKey:@"result"];
                if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                    NSArray *modelArray = [CommentModel transferCommentModels:commentArray];
                    [_dataArray removeAllObjects];
                    [_dataArray addObjectsFromArray:modelArray];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tableView reloadData];
                        [_tableView.mj_header endRefreshing];
                    });
                  
                }
                else
                {
                  [self errorWaring];
                }
            }
            else
            {
                [self errorWaring];
            }
          });
        
    } fail:^(id error) {
        [self errorWaring];
    }];
 
}

-(void)errorWaring{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取评价失败" time:0.8f];
        [_tableView.mj_header endRefreshing];
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001f;
    }else{
        return 7.0f;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
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
    CommentModel *model = _dataArray[indexPath.section];
    return model.cellHeight+model.footerHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CommentCellID = @"CommentCellID";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellID];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.section;
    [cell fillInCellFooter:_dataArray[indexPath.section]];

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
