//
//  ShConsultantDetailInfoViewController.m
//  duxin
//
//  Created by felix on 2018/1/25.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShConsultantDetailInfoViewController.h"
#import "ShConsultantDetailTableViewCell.h"
#import "ShConsultantJudgeTableViewCell.h"
#import "ShConsultantInfoModel.h"
#import "ShConsultantCommentModel.h"
#import "ShConsultantCommentDetailModel.h"
#import "ShConsultantPackageModel.h"
#import "UILabel+SuggestSize.h"
#import "NSString+Util.h"
#import "ShAllCommentViewController.h"
#import "ShCredentialsCertifyViewController.h"
#import "PaymentViewController.h"
#import "ServiceDetailViewController.h"
#import "CustomerServiceViewController.h"
#import "LoginViewController.h"

#define HEIGHT_15 15
#define HEIGHT_50 50
#define HEIGHT_45 45
#define HEIGHT_300 300
#define HEIGHT_60 60

#define COMMENT_NUM 2 //评价默认展示条数

#define SH_CONSULTEINFO_CELL @"ShConsultantDetailTableViewCell"

#define SH_CONSULTEJUDGE_CELL @"ShConsultantJudgeTableViewCell"


@interface ShConsultantDetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *consultTableview;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *attentionBtn;
@property (strong, nonatomic) UIButton *chatBtn;
@property (assign, nonatomic) NSInteger dynamicCellHeight;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *photoImagView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIButton *addressBtn;
@property (strong, nonatomic) UILabel *leftTagNum;//收到感谢
@property (strong, nonatomic) UILabel *centerTagNum;//已咨询
@property (strong, nonatomic) UILabel *rightTagNum;//粉丝关注
@property (strong, nonatomic) NSArray *tagArray;

@property (strong, nonatomic) UIButton *introduceBtn;
@property (strong, nonatomic) UIButton *judgeBtn;
@property (strong, nonatomic) UIView *introduceLine;
@property (assign, nonatomic) BOOL hasLeft;//介绍 NO 评价 YES
@property (assign, nonatomic) BOOL hasSpread;//五条或五条以下 NO 五条以上 YES



@property (strong, nonatomic) ShConsultantInfoModel *consultantInfoModel;//咨询师详情数据
@property (strong, nonatomic) ShConsultantCommentModel *commentModel;
@property (strong, nonatomic) ShConsultantCommentDetailModel *commentDetailModel;
@property (strong, nonatomic) NSMutableArray *commentListArray;
@property (strong, nonatomic) NSMutableArray *packageArray;


@property (assign, nonatomic) CGFloat footerHeight;
@property (strong, nonatomic) UIScrollView *footerScrollView;
@property (strong, nonatomic) UIView *footerSection2View;
@property (strong, nonatomic) UIView *footerLeftView;
@property (strong, nonatomic) UITableView *footerRightTableView;

@property (assign, nonatomic) CGFloat introduceHeight;//介绍 label 高度
@property (strong, nonatomic) UILabel *introduceLabel;//介绍 label
@property (strong, nonatomic) UIButton *spreadAllBtn;



@end

@implementation ShConsultantDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navView.hidden= NO;
    [self.navView setMj_h:Height_StatusBar];
    
    self.hasLeft = NO;
    self.hasSpread = NO;
    self.tagArray = [[NSArray alloc] init];
    self.footerHeight = 420;
    self.introduceHeight = 100;
    
    self.packageArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.commentListArray = [[NSMutableArray alloc] initWithCapacity:0];


    [self createUI];
    
    [self getConstultDetailData];
    
    [self getCommentsData];

    
}


#pragma mark --get consultant detail data--
-(void)getConstultDetailData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",FetchConsultantInfo,self.strID];
    @weakify(self)
    [[LKProtocolNetworkEngine sharedInstance] protocolWithUrl:urlString
        requestDictionary:dic
         responseModelCls:[ShConsultantInfoModel class]
        completionHandler:^(LMModel *response,SHModel *responseC, NSError *error) {
            @normalize(self)
            if (response.code == 200 && responseC.error_code == 0) {
                
                self.consultantInfoModel = responseC.result;
    
                self.packageArray = [ShConsultantPackageModel mj_objectArrayWithKeyValuesArray:self.consultantInfoModel.consultationPackage];
              
                if (self.consultantInfoModel.IsFollow == YES) {
                    [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantAttenion")] forState:UIControlStateNormal];
                }else{
                    [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantUnAttenion")] forState:UIControlStateNormal];
                }
                self.tagArray = [self.consultantInfoModel.consultantProfile.tags componentsSeparatedByString:@","];
                self.introduceLabel.text = self.consultantInfoModel.introduction;
       
        
              
                
                [self.consultTableview reloadData];
                //计算 介绍 的高度 
                
            }else{
                [SVProgressHUD showWithStatus:responseC.msg];
            }
        }];
}

#pragma mark --get consultant comment data--
-(void)getCommentsData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.strID forKey:@"id"];
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"limit"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",FetchConsultantComment,self.strID];
    @weakify(self)
    [[LKProtocolNetworkEngine sharedInstance] protocolWithUrl:urlString
        requestDictionary:dic
         responseModelCls:[ShConsultantCommentModel class]
        completionHandler:^(LMModel *response,SHModel *responseC, NSError *error) {
            @normalize(self)
            if (response.code == 200 && responseC.error_code == 0) {
                NSLog(@"comment result = %@",responseC.result);
                
                self.commentModel = responseC.result;
                self.commentListArray = [ShConsultantCommentDetailModel mj_objectArrayWithKeyValuesArray:self.commentModel.list];
                __block  CGFloat allHeight = 0;
                [self.commentListArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ShConsultantCommentDetailModel *detailModel = obj;
                    NSString *strEvaluation = detailModel.evaluation;
                    CGSize size = [strEvaluation sizeWithFont:FONT_14 constrainedToWidth:SIZE.width - 113];
                    CGFloat cellHeight = 123;
                    if (size.height>=20) {
                        allHeight = allHeight + size.height + cellHeight;
                    }else{
                        allHeight = allHeight + 20 + cellHeight;
                    }
                    if (idx == COMMENT_NUM - 1) {
                        *stop = YES;
                    }
                }];
                
                self.footerHeight = allHeight + 50;

                [self.consultTableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                [self.footerRightTableView reloadData];

            }else{
             
            }
        }];
}


-(void)createUI
{
    self.consultTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.consultTableview.tag = 1;
    self.consultTableview.dataSource = self;
    self.consultTableview.delegate = self;
    self.consultTableview.separatorColor = [UIColor clearColor];
    self.consultTableview.showsVerticalScrollIndicator = FALSE;
    self.consultTableview.showsHorizontalScrollIndicator = FALSE;
    self.consultTableview.backgroundColor = [UIColor clearColor];
    [self.consultTableview registerClass:[ShConsultantDetailTableViewCell class] forCellReuseIdentifier:SH_CONSULTEINFO_CELL];
    [self.view addSubview:self.consultTableview];
    [self.consultTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
        
    }];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SIZE.height - 50, SIZE.width, 50)];
    [self.view addSubview:self.bottomView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 1)];
    line.backgroundColor = Color_EEEEEE;
    [self.bottomView addSubview:line];

    self.attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.attentionBtn layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    self.attentionBtn.frame = CGRectMake(0, line.frame.size.height, SIZE.width/2 + 40, self.bottomView.frame.size.height - line.frame.size.height);
    [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    self.attentionBtn.adjustsImageWhenDisabled = NO;
    [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantUnAttenion")] forState:UIControlStateNormal];
    [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantUnAttenion")] forState:UIControlStateHighlighted];
    [self.attentionBtn setTitleColor:Color_8D989C forState:UIControlStateNormal];
    [self.attentionBtn addTarget:self action:@selector(attentionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.attentionBtn];
    
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chatBtn layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    self.chatBtn.frame = CGRectMake(self.attentionBtn.frame.size.width, self.attentionBtn.frame.origin.y, SIZE.width - self.attentionBtn.frame.size.width, self.bottomView.frame.size.height - line.frame.size.height);
    self.chatBtn.adjustsImageWhenDisabled = NO;
    [self.chatBtn setTitle:@"私聊" forState:UIControlStateNormal];
    [self.chatBtn setImage:[UIImage imageNamed:Image(@"sonsultantChat")] forState:UIControlStateNormal];
    [self.chatBtn setImage:[UIImage imageNamed:Image(@"sonsultantChat")] forState:UIControlStateHighlighted];
    self.chatBtn.backgroundColor = Color_5DCBF5;
    [self.chatBtn addTarget:self action:@selector(privateChat:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.chatBtn];

    
}

-(void)privateChat:(UIButton *)button{
    
    CacheChatReceiverAdvatar(CustomServiceAdvatar);
    CustomerServiceViewController *vc =[[CustomerServiceViewController alloc] initWithConversationChatter:EMCUSTOMERNUMBERT conversationType:EMConversationTypeChat];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark --UITabBarDelegate && UITableViewDataSource--
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        return 3;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 1) {
        if (section == 0) {
            return 0;
        }else if (section == 1){
            if (self.packageArray.count>5 ) {
                if (self.hasSpread == YES) {
                    return self.packageArray.count;
                }else{
                    return 5;
                }
            }else{
                return self.packageArray.count;
            }
        }else{
            return 0;
        }
    }else{
        
        if(self.commentListArray.count >= COMMENT_NUM){
            
            return COMMENT_NUM;
        }
        else{
            return  self.commentListArray.count;
        }
        
        
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        if (indexPath.section == 1) {
            
            ShConsultantDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SH_CONSULTEINFO_CELL];
            if (!cell) {
                cell = [[ShConsultantDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SH_CONSULTEINFO_CELL];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ShConsultantPackageModel *packageModel = self.packageArray[indexPath.row];
            [cell reloadUI:packageModel];
            [cell setFrame:CGRectMake(0, 0, SIZE.width, HEIGHT_60)];
            return cell;
        }
        return nil;
    }else{

            ShConsultantJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SH_CONSULTEJUDGE_CELL];
            if (!cell) {
                cell = [[ShConsultantJudgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SH_CONSULTEJUDGE_CELL];
            }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (indexPath.row == 1) {
                cell.line.hidden = YES;
            }
        
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
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 1) {
        return  [self createHeaderView:section];

    }else{
        return [UIView new];
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return  [self createFooterView:section];

    }else{
      return  [self createMoreCommentBtnView];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        
        ShConsultantDetailTableViewCell *cell = (ShConsultantDetailTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }else{
        ShConsultantJudgeTableViewCell *cell = (ShConsultantJudgeTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        if (section == 0) {
            return HEIGHT_300;
        }else{
            return HEIGHT_45;
        }
    }else{
        return  0.0001;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (tableView.tag == 1) {
        if (section == 1) {
            if (self.packageArray.count >5) {
                if (self.hasSpread == YES) {//点击“展开全部”之后 不显示
                    return 5;
                }else{
                    return 40;

                }
            }else{
                return 5;
            }
            
        }else if (section == 2)
        {
            NSLog(@"self.footer==>%f",self.footerHeight);
            return self.footerHeight;
        }
        return 0.0001;
    }else
    {
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShConsultantPackageModel *model = _packageArray[indexPath.row];
    ServiceDetailViewController *vc  = [[ServiceDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.idString  = [NSString stringWithFormat:@"%ld",(long)model.id];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UIView *)createHeaderView:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];

    if (section == 0) {
        headerView.frame = CGRectMake(0, 0, SIZE.width, HEIGHT_300);
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, headerView.frame.size.height)];
        self.backImageView.image = [UIImage imageNamed:Image(@"consultantBackImage")];
        self.backImageView.backgroundColor = Color_8BBAC4;
        [headerView addSubview:self.backImageView];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.frame = CGRectMake(5, 10, 30, 30);
        [self.backBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateHighlighted];
        [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.backBtn];
        
        self.shareBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareBtn.frame = CGRectMake(SIZE.width - 40, 10, 30, 30);
        [self.shareBtn setImage:[UIImage imageNamed:Image(@"consultantShare")] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:Image(@"consultantShare")] forState:UIControlStateHighlighted];
        [self.shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.shareBtn];
        
        self.photoImagView = [[UIImageView alloc] initWithFrame:CGRectMake((SIZE.width - 80)/2, 68 , 80, 80)];
        self.photoImagView.layer.cornerRadius = self.photoImagView.frame.size.width/2;
        self.photoImagView.clipsToBounds = YES;
        self.photoImagView.backgroundColor = Color_5DCBF5;
        self.photoImagView.layer.borderColor = Color_CBE3E8.CGColor;
        self.photoImagView.layer.borderWidth = 1;
        [self.photoImagView sd_setImageWithURL:[NSURL URLWithString:self.consultantInfoModel.avatar] placeholderImage:nil];
        [headerView addSubview:self.photoImagView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, self.photoImagView.frame.origin.y + self.photoImagView.frame.size.height + 6, SIZE.width - 80 * 2, 20)];
        self.nameLabel.text = self.consultantInfoModel.name;
        self.nameLabel.textAlignment= NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = FONT_15;
        [headerView addSubview:self.nameLabel];
        
        self.addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addressBtn layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        self.addressBtn.frame = CGRectMake(80, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5, SIZE.width - 80 * 2, 20);
        [self.addressBtn setTitle:self.consultantInfoModel.area forState:UIControlStateNormal];
        [self.addressBtn setImage:[UIImage imageNamed:Image(@"consultantLocation")] forState:UIControlStateNormal];
        [self.addressBtn layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        self.addressBtn.titleLabel.font = FONT_12;
        [self.addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [headerView addSubview:self.addressBtn];
        
        
        CGFloat labelWidth = 60;
        CGFloat labelHeight = 20;
        CGFloat labelDistance = 10;
        CGFloat labelPointX = (SIZE.width - (labelWidth *self.tagArray.count + labelDistance * (self.tagArray.count - 1)))/2;
        CGFloat labelPoineY = self.addressBtn.frame.origin.y + self.addressBtn.frame.size.height + 13;
        [self.tagArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UILabel *tagLabel = [[UILabel alloc] init];
            tagLabel.frame = CGRectMake(labelPointX + (labelWidth + labelDistance) *idx, labelPoineY, labelWidth, labelHeight);
            tagLabel.text = obj;
            tagLabel.textAlignment = NSTextAlignmentCenter;
            tagLabel.textColor = [UIColor whiteColor];
            tagLabel.font = FONT_12;
            tagLabel.layer.cornerRadius = labelHeight/2;
            tagLabel.clipsToBounds = YES;
            tagLabel.layer.borderColor = [UIColor whiteColor].CGColor;
            tagLabel.layer.borderWidth = 0.5;
            [headerView addSubview:tagLabel];
        }];
        
        
        self.leftTagNum = [[UILabel alloc] initWithFrame:CGRectMake(0, labelPoineY + labelHeight + 24, SIZE.width/3, 20)];
        self.leftTagNum.textColor = [UIColor whiteColor];
        self.leftTagNum.font = FONT_15;
        self.leftTagNum.textAlignment = NSTextAlignmentCenter;
        if (self.consultantInfoModel.praise == nil)
        {
            self.leftTagNum.text = [NSString stringWithFormat:@"100%%"];
        }
        else
        {
           self.leftTagNum.text = [NSString stringWithFormat:@"%@",self.consultantInfoModel.praise];
        }
        
        [headerView addSubview:self.leftTagNum];
        
        
        UILabel * bottomView1 = [[UILabel alloc] initWithFrame:CGRectMake(self.leftTagNum.frame.origin.x, self.leftTagNum.frame.origin.y + self.leftTagNum.frame.size.height, self.leftTagNum.frame.size.width, 15)];
        bottomView1.text = @"收到感谢";
        bottomView1.textColor = [UIColor whiteColor];
        bottomView1.font = FONT_10;
        bottomView1.alpha = 0.6;
        bottomView1.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:bottomView1];
        
        
        self.centerTagNum = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width/3, self.leftTagNum.frame.origin.y, self.leftTagNum.frame.size.width, self.leftTagNum.frame.size.height)];
        self.centerTagNum.text = [NSString stringWithFormat:@"%zd",self.consultantInfoModel.orderCount];
        self.centerTagNum.textColor = [UIColor whiteColor];
        self.centerTagNum.font = FONT_15;
        self.centerTagNum.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:self.centerTagNum];
        
        UILabel * bottomView2 = [[UILabel alloc] initWithFrame:CGRectMake(self.centerTagNum.frame.origin.x, bottomView1.frame.origin.y, self.centerTagNum.frame.size.width, 15)];
        bottomView2.text = @"已咨询";
        bottomView2.textColor = [UIColor whiteColor];
        bottomView2.font = FONT_10;
        bottomView2.alpha = 0.6;
        bottomView2.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:bottomView2];
        
        self.rightTagNum = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width/3 * 2, self.leftTagNum.frame.origin.y, self.leftTagNum.frame.size.width, self.leftTagNum.frame.size.height)];
        self.rightTagNum.text =[NSString stringWithFormat:@"%zd",self.consultantInfoModel.followCount];
        self.rightTagNum.textColor = [UIColor whiteColor];
        self.rightTagNum.font = FONT_15;
        self.rightTagNum.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:self.rightTagNum];
        
        UILabel * bottomView3 = [[UILabel alloc] initWithFrame:CGRectMake(self.rightTagNum.frame.origin.x, bottomView1.frame.origin.y, self.rightTagNum.frame.size.width, 15)];
        bottomView3.text = @"粉丝关注";
        bottomView3.textColor = [UIColor whiteColor];
        bottomView3.font = FONT_10;
        bottomView3.alpha = 0.6;
        bottomView3.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:bottomView3];
        
        

    }
    else if (section == 1)
    {
        headerView.frame = CGRectMake(0, 0, SIZE.width, HEIGHT_45);
        NSMutableArray *titleArr = [[NSMutableArray alloc] init];
        [titleArr addObject:@"资质认证"];
        [titleArr addObject:@"交易担保"];
        [titleArr addObject:@"不满意退款"];

        NSArray *imageArr = @[[UIImage imageNamed:Image(@"consultantQualify")],[UIImage imageNamed:Image(@"consultantGuarantee")],[UIImage imageNamed:Image(@"consultantRefund")]];
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGFloat btnWidth = 80;
            CGFloat btnHeight = HEIGHT_45 - (15/2) * 2;
            CGFloat btnPointX = 13 + (btnWidth + 10) *idx;
            CGFloat btnPointY = HEIGHT_15/2;
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnPointX, btnPointY, btnWidth,btnHeight);
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setImage:imageArr[idx] forState:UIControlStateNormal];
            [btn setImage:imageArr[idx] forState:UIControlStateHighlighted];
            [btn setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
            btn.titleLabel.font = FONT_13;
            [btn layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:5];
            [headerView addSubview:btn];
        }];
        
        UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SIZE.width - 40, (HEIGHT_45 - 30)/2, 30,30);
        [rightBtn setImage:[UIImage imageNamed:Image(@"consultantMore")] forState:UIControlStateNormal];
        [headerView addSubview:rightBtn];
        
        UIButton *clickBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = CGRectMake(0, 0, headerView.frame.size.width,headerView.frame.size.height);
        clickBtn.backgroundColor = [UIColor clearColor];
        [clickBtn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:clickBtn];
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, HEIGHT_45 - 0.5, SIZE.width, 0.5);
        line.backgroundColor = Color_EEEEEE;
        [headerView addSubview:line];
    }
    else
    {
        headerView.backgroundColor = [UIColor whiteColor];
        self.introduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.introduceBtn.frame = CGRectMake(0, HEIGHT_15, 90, HEIGHT_45 - HEIGHT_15 * 2);
        [self.introduceBtn setTitle:@"介绍" forState:UIControlStateNormal];
        [self.introduceBtn setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
        self.introduceBtn.titleLabel.font = FONT_15;
        [self.introduceBtn addTarget:self action:@selector(introduceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.introduceBtn];
        
        self.introduceLine = [[UIView alloc] init];
        if (self.hasLeft) {
            self.introduceLine.frame = CGRectMake(self.introduceBtn.frame.size.width, HEIGHT_45 - 2, self.introduceBtn.frame.size.width, 2);
        }else{
            self.introduceLine.frame = CGRectMake(0, HEIGHT_45 - 2, self.introduceBtn.frame.size.width, 2);
        }
        self.introduceLine.backgroundColor = Color_5DCBF5;
        [headerView addSubview:self.introduceLine];
        
        self.judgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.judgeBtn.frame = CGRectMake(self.introduceBtn.frame.size.width, HEIGHT_15, self.introduceBtn.frame.size.width, HEIGHT_45 - HEIGHT_15 * 2);
        NSString *strjudge = [NSString stringWithFormat:@"评价(%ld)",(long)self.commentListArray.count];
        [self.judgeBtn setTitle:strjudge forState:UIControlStateNormal];
        [self.judgeBtn setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
        self.judgeBtn.titleLabel.font = FONT_15;
        [self.judgeBtn addTarget:self action:@selector(judgeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.judgeBtn];
        
    }
    
    return headerView;
}

-(UIView *)createFooterView:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    if (section == 2) {
        
        if (!self.footerSection2View) {
            self.footerSection2View = [[UIView alloc] init];
            self.footerSection2View.backgroundColor = [UIColor whiteColor];
            self.footerSection2View.frame = CGRectMake(0, 0, SIZE.width, self.footerHeight);
            self.footerSection2View.backgroundColor = [UIColor whiteColor];
            
            self.footerScrollView = [[UIScrollView alloc] init];
            self.footerScrollView.frame = CGRectMake(0, 0, SIZE.width, self.footerHeight);
            self.footerScrollView.contentSize = CGSizeMake(SIZE.width*2, self.footerHeight);
            self.footerScrollView.showsVerticalScrollIndicator = FALSE;
            self.footerScrollView.showsHorizontalScrollIndicator = FALSE;
            self.footerScrollView.pagingEnabled = YES;
            self.footerScrollView.delegate = self;
            self.footerScrollView.scrollEnabled = NO;
            [self.footerSection2View addSubview:self.footerScrollView];
            
            self.footerLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, self.footerScrollView.frame.size.height)];
            self.footerLeftView.userInteractionEnabled = YES;
            [self.footerScrollView addSubview:self.footerLeftView];
            
            
            self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SIZE.width - 20, self.introduceHeight)];
            self.introduceLabel.backgroundColor = [UIColor whiteColor];
            self.introduceLabel.text = self.consultantInfoModel.introduction;
            self.introduceLabel.font = FONT_14;
            self.introduceLabel.textColor = Color_1F1F1F;
            self.introduceLabel.numberOfLines = 0;
            self.introduceLabel.lineBreakMode= UILineBreakModeWordWrap;
            [self.footerLeftView addSubview:self.introduceLabel];
            
           self.spreadAllBtn= [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat btnWidth = 120;
            CGFloat btnX =(SIZE.width - btnWidth)/2;
            self.spreadAllBtn.frame= CGRectMake(btnX, self.introduceHeight + 30, btnWidth, 30);
            self.spreadAllBtn.titleLabel.font = FONT_15;
            [self.spreadAllBtn setTitle:@"展开全部" forState:UIControlStateNormal];
            [self.spreadAllBtn setTitleColor:Color_5DCBF5 forState:UIControlStateNormal];
            self.spreadAllBtn.layer.borderColor = Color_5DCBF5.CGColor;
            self.spreadAllBtn.layer.borderWidth = 1;
            self.spreadAllBtn.layer.cornerRadius = 2;
            self.spreadAllBtn.clipsToBounds = YES;
            self.spreadAllBtn.userInteractionEnabled = YES;
            [self.spreadAllBtn addTarget:self action:@selector(spreadAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.footerLeftView addSubview:self.spreadAllBtn];
            
            self.footerRightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            self.footerRightTableView.frame= CGRectMake(SIZE.width, 0, SIZE.width, self.footerHeight);
            self.footerRightTableView.tag = 2;
            self.footerRightTableView.delegate = self;
            self.footerRightTableView.dataSource = self;
            self.footerRightTableView.bounces = NO;
            self.footerRightTableView.scrollEnabled = YES;
            self.footerRightTableView.separatorColor = [UIColor clearColor];
            self.footerRightTableView.backgroundColor = [UIColor whiteColor];
            [self.footerRightTableView registerClass:[ShConsultantJudgeTableViewCell class] forCellReuseIdentifier:SH_CONSULTEJUDGE_CELL];
            self.footerRightTableView.showsHorizontalScrollIndicator = FALSE;
            self.footerRightTableView.showsVerticalScrollIndicator = FALSE;
            [self.footerScrollView addSubview:self.footerRightTableView];
        }
        self.footerSection2View.frame = CGRectMake(0, 0, SIZE.width, self.footerHeight);
        self.footerScrollView.frame = CGRectMake(0, 0, SIZE.width, self.footerHeight);
        self.footerRightTableView.frame= CGRectMake(SIZE.width, 0, SIZE.width, self.footerHeight);

        return self.footerSection2View;
        
    }else if (section == 1)
    {
        if (self.packageArray.count >5) {
            if (self.hasSpread == YES) {//点击“展开全部”之后 不显示
                footerView.frame = CGRectMake(0, 0, SIZE.width, 5);
            }
            else{//没有点击“展开全部”之前 显示
                footerView.frame = CGRectMake(0, 0, SIZE.width, 40);
                footerView.backgroundColor = [UIColor whiteColor];
                UIButton *moreBtn= [UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat btnWidth = 120;
                CGFloat btnX =(SIZE.width - btnWidth)/2;
                moreBtn.frame= CGRectMake(btnX, 5, btnWidth, 30);
                moreBtn.titleLabel.font = FONT_15;
                [moreBtn setTitle:@"展开全部" forState:UIControlStateNormal];
                [moreBtn setTitleColor:Color_5DCBF5 forState:UIControlStateNormal];
                moreBtn.layer.borderColor = Color_5DCBF5.CGColor;
                moreBtn.layer.borderWidth = 1;
                moreBtn.layer.cornerRadius = 2;
                moreBtn.clipsToBounds = YES;
                moreBtn.userInteractionEnabled = YES;
                [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [footerView addSubview:moreBtn];
                
            }
           
        }else{
            footerView.frame = CGRectMake(0, 0, SIZE.width, 5);
        }
        footerView.backgroundColor = Color_EEEEEE;
        return footerView;

    }else{
        return footerView;
    }
   
}

-(UIView *)createMoreCommentBtnView
{
    UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 40)];
    moreView.backgroundColor = [UIColor whiteColor];
    UIButton *btnMoreComment = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnWidth = 120;
    CGFloat btnX =(SIZE.width - btnWidth)/2;
    btnMoreComment.frame= CGRectMake(btnX, 5, btnWidth, 30);
    btnMoreComment.titleLabel.font = FONT_15;
    [btnMoreComment setTitle:@"查看更多评价" forState:UIControlStateNormal];
    [btnMoreComment setTitleColor:Color_5DCBF5 forState:UIControlStateNormal];
    btnMoreComment.layer.borderColor = Color_5DCBF5.CGColor;
    btnMoreComment.layer.borderWidth = 1;
    btnMoreComment.layer.cornerRadius = 2;
    btnMoreComment.clipsToBounds = YES;
    [btnMoreComment addTarget:self action:@selector(btnMoreCommentClick) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:btnMoreComment];
    return moreView;
    
}

#pragma mark --UIScrollViewDelegate--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //ScrollView中根据滚动距离来判断当前页数
    NSInteger page = (NSInteger)self.footerScrollView.contentOffset.x/self.footerScrollView.frame.size.width;
    if (page == 1) {
        [UIView animateWithDuration:0.1 animations:^{
            self.introduceLine.frame = CGRectMake(self.introduceBtn.frame.size.width, HEIGHT_45 - 2, self.introduceBtn.frame.size.width, 2);
            self.hasLeft = YES;
            
        }];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.introduceLine.frame = CGRectMake(0, HEIGHT_45 - 2, self.introduceBtn.frame.size.width, 2);
            self.hasLeft = NO;
            
        }];
        
    }
    
}


-(void)clickBtnAction
{
    ShCredentialsCertifyViewController *certifyVC = [ShCredentialsCertifyViewController new];
    certifyVC.hidesBottomBarWhenPushed = YES ;
    certifyVC.strName = self.consultantInfoModel.name;
    certifyVC.strURL =self.consultantInfoModel.consultantProfile.qualified_cert;
    [self.navigationController pushViewController:certifyVC animated:YES];
}

#pragma mark ---more btn click action--
-(void)moreBtnClick:(UIButton *)sender
{
    self.hasSpread = YES;
    [self.consultTableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark --introduce btn click action--
-(void)introduceBtnClick
{
    [UIView animateWithDuration:0.1 animations:^{
        self.introduceLine.frame = CGRectMake(0, HEIGHT_45 - 2, self.introduceBtn.frame.size.width, 2);
        self.hasLeft = NO;
        self.footerScrollView.contentOffset = CGPointMake(0, 0);

    }];

}

#pragma mark --judge btn click action --
-(void)judgeBtnClick
{
    [UIView animateWithDuration:0.1 animations:^{
        self.introduceLine.frame = CGRectMake(self.introduceBtn.frame.size.width, HEIGHT_45 - 2, self.introduceBtn.frame.size.width, 2);
        self.hasLeft = YES;
        self.footerScrollView.contentOffset = CGPointMake(SIZE.width, 0);

    }];
}

#pragma mark --more comment btn click action --
-(void)btnMoreCommentClick
{
    ShAllCommentViewController *commentVC = [[ShAllCommentViewController alloc] init];
    commentVC.hidesBottomBarWhenPushed = YES ;
    commentVC.strID = _strID;
    [self.navigationController pushViewController:commentVC animated:YES];
    
    
}
#pragma mark --spread all introduce btn click action --
-(void)spreadAllBtnClick
{

    CGSize size = [self.introduceLabel suggestedSizeForWidth:SIZE.width - 20];
    self.introduceHeight = size.height;
    self.introduceLabel.frame = CGRectMake(10, 10, SIZE.width - 20, size.height);
    self.footerHeight = self.introduceHeight +100;
    self.spreadAllBtn.hidden = YES;
    [self.consultTableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark --share btn click action --
-(void)shareBtnClick
{
    
}

#pragma mark --back btn click action --
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark --attention btn click action --
-(void)attentionBtnClick
{
    NSString *string = FetchToken;
    if (string != nil)
    {
        NSLog(@"isFollow==>%ld",(long)self.consultantInfoModel.IsFollow);
        [self judgeFollow:self.consultantInfoModel.IsFollow];
    }
    else
    {
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark --yes or no follow data--
-(void)judgeFollow:(BOOL)isFollow{
    
        NSString *strUrl;
        if (isFollow) {//取消关注
            strUrl = FetchUnFollowConsultant;
        }
        else{//关注
            strUrl = FetchFollowConsultant;
        }
        strUrl = [NSString stringWithFormat:@"%@%@",strUrl,self.strID];
    HttpsManager *httsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.strID forKey:@"id"];
    [httsManager postServerAPI:strUrl deliveryDic:dic successful:^(id responseObject) {
        NSLog(@"responseObject==>%@",responseObject);
        if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] ==0) {
                
                if (isFollow)
                {
                    self.consultantInfoModel.IsFollow = NO;
                    [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantUnAttenion")] forState:UIControlStateNormal];
                }
                else
                {
                    self.consultantInfoModel.IsFollow = YES;
                    [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantAttenion")] forState:UIControlStateNormal];
                }
                [SVHUD showSuccessWithDelay:[dataDic objectForKey:@"msg"] time:0.8f];
            }
            else
            {
                
                 [SVHUD showErrorWithDelay:[dataDic objectForKey:@"msg"] time:0.8f];
                
            }
            
        }
        else
        {
            [SVHUD showErrorWithDelay:[responseObject objectForKey:@"msg"] time:0.8f];
        }
        
        
        
    } fail:^(id error) {
        
    }];
    
    
    
}

#pragma mark --yes or no follow data--
//-(void)judgeFollow:(BOOL)isFollow
//{
//    NSString *strUrl;
//    if (isFollow) {//取消关注
//        strUrl = FetchUnFollowConsultant;
//    }
//    else{//关注
//        strUrl = FetchFollowConsultant;
//    }
//    strUrl = [NSString stringWithFormat:@"%@%@",strUrl,self.strID];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:self.strID forKey:@"id"];
//    [[LKProtocolNetworkEngine sharedInstance] protocolWithRequestMethod:REQUEST_METHOD_POST
//                 requestUrl:strUrl
//               requestModel:dic
//           responseModelCls:[SHModel class]
//        completionHandler:^(LMModel *response,SHModel *responseC, NSError *error) {
//              if (response.code == 200 && responseC.error_code == 0) {
//                  [SVProgressHUD showSuccessWithStatus:responseC.msg];
//                  if (isFollow) {
//                      self.consultantInfoModel.IsFollow = NO;
//                      [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantUnAttenion")] forState:UIControlStateNormal];
//                  }else{
//                      self.consultantInfoModel.IsFollow = YES;
//                      [self.attentionBtn setImage:[UIImage imageNamed:Image(@"consultantAttenion")] forState:UIControlStateNormal];
//                  }
//              }else{
//                  [SVProgressHUD showErrorWithStatus:responseC.msg];
//              }
//          }];
//}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
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
