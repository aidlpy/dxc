//
//  CommentViewController.m
//  duxin
//
//  Created by 37duxin on 29/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CommentViewController.h"
#import "EditCommentCell.h"
#import "CommentProfile.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_headerImageView;
    CustomTextView *_textView;
    UILabel *_titleLabel;
    CommentProfile *_model;
    int _startNumber;
    BOOL _isSelected;
}
@end

@implementation CommentViewController
#pragma --fetchConsulatingInfo---
void fetchData(CommentViewController *selfVC) {
    HttpsManager *httpmanager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",FetchConsultinProfile,selfVC.orderId];
    [dic setObject:selfVC.isMainOrder?@"1":@"0" forKey:@"type"];
    [httpmanager getServerAPI:urlStr deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            
            if ([[dataDic objectForKey:@"code"] integerValue] ==200) {
                
                NSDictionary *resultDic = [dataDic objectForKey:@"result"];
                
                if ([[resultDic objectForKey:@"err_code"] integerValue] == 0) {
                    
                    selfVC->_model = [CommentProfile fetchModelsArray:[[dataDic objectForKey:@"data"] objectForKey:@"result"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [selfVC->_titleLabel setText:selfVC->_model.name];
                        [selfVC->_headerImageView sd_setImageWithURL:[NSURL URLWithString:selfVC->_model.avatar]];
                        [selfVC->_model.tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            
                            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x(selfVC->_titleLabel)+idx*64,selfVC->_headerImageView.center.y+3,60,20)];
                            [btn setTitle:obj forState:UIControlStateNormal];
                            [btn setTitleColor:selfVC->_titleLabel.textColor forState:UIControlStateNormal];
                            btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
                            [btn.layer setBorderColor:Color_F1F1F1.CGColor];
                            [btn.layer setBorderWidth:1.0f];
                            [btn.layer setCornerRadius:h(btn)/2];
                            [selfVC->_headerView addSubview:btn];
                            
                        }];
                    });
                }
                else
                {
                    [selfVC errorWarning];
                }
            }
            else
            {
                [selfVC errorWarning];
            }
        });
    } fail:^(id error) {
       [selfVC errorWarning];
    }];
}


void postData(CommentViewController *selfVC)
{
    HttpsManager *httpmanager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@",selfVC.isMainOrder?postConsultingComment:postReservationComment,selfVC.orderId];
    [dic setObject:[NSString stringWithFormat:@"%d",selfVC->_startNumber] forKey:@"start"];
    [dic setObject:selfVC->_textView.text forKey:@"evaluation"];
    [httpmanager postServerAPI:url deliveryDic:dic successful:^(id responseObject) {
             dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 NSDictionary *dicData = (NSDictionary *)responseObject;
                 if ([[dicData objectForKey:@"code"] integerValue] == 200) {
                     NSDictionary *dataDic =  [dicData objectForKey:@"data"];
                     if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [selfVC successful];
                          });
                     }
                     else
                     {
                         [selfVC errorWarning];
                     }
                 }
                 else
                 {
                     [selfVC errorWarning];
                 }
             });
    } fail:^(id error) {
        [selfVC errorWarning];
    }];
}

-(void)errorWarning{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"提交评价失败！" time:0.8f];
    });
}

-(void)successful{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showSuccessWithDelay:@"提交评价成功" time:0.8f blockAction:^{
             [self backTo];
        }];
    });
}


-(void)dealloc{
    [SVProgressHUD dismiss];
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
    fetchData(self);
}

-(void)initData{
    _isSelected = NO;
    _startNumber =5;
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"评论" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(self.navView), SIZE.width, SIZE.height-bottom(self.navView)) style:UITableViewStyleGrouped];
    _tableView.backgroundView = [[UIImageView alloc] initWithFrame:_tableView.frame];
    _tableView.tableHeaderView = [self customTableHeaderView];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

-(UIView *)customTableHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 77)];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9,11,53,53)];
    _headerImageView.clipsToBounds = YES;
    _headerImageView.backgroundColor = Color_F1F1F1 ;
    [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
    [_headerView addSubview:_headerImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImageView)+8,15,SIZE.width-70, 20)];
    _titleLabel.text = _model.name;
    _titleLabel.textColor = Color_1F1F1F;
    [_headerView addSubview:_titleLabel];

    return _headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Color_F1F1F1;
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 390.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *editCommentCell = @"EditCommentCell";
    EditCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:editCommentCell];
    if (cell == nil) {
        cell = [[EditCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editCommentCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.section;
    _textView = cell.textView;
    cell.fetchPercentBlock = ^(CGFloat startNumber) {
        _startNumber = startNumber;
        NSLog(@"%d",_startNumber);
    };
    cell.postCommentBlock = ^(CGFloat startNumber) {
       // _startNumber = startNumber;
        postData(self);
    };
    return cell;
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
