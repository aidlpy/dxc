//
//  ConsultingOrdersCell.m
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingOrdersCell.h"

@implementation ConsultingOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//深度咨询子菜单
-(void)setConsultingSubOrderCell:(NSInteger)cellStytleCode{
    NSLog(@"cellStytleCode==>%d",(int)cellStytleCode);
    switch (cellStytleCode) {
        case 0:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"待咨询";
            [self.wiatingPayBtn setTitle:@"去咨询" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
            
        }
            break;
        case 1:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"待评价";
            [self.wiatingPayBtn setTitle:@"去评价" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"已评价";
            [self.wiatingPayBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            UIColor *color =Color_FA9E4B;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_FA9E4B forState:UIControlStateNormal];
        }
            break;
            
            
        default:
            break;
    }
}

-(void)fetchMainData:(ConsultingMainModel *)model{
    
    self.nameLab.text = model.consultantName;
    self.nameLab.backgroundColor = [UIColor whiteColor];
    
    self.packageTitle.text = model.packageTitle;
    self.packageTitle.backgroundColor = [UIColor whiteColor];
    
    self.packageCount.text = model.packageSinglePrice;
    self.packageCount.frame = CGRectMake(x(self.packageCount), y(self.packageCount),[ZSize sizeWidth:self.packageCount], h(self.packageCount));
    self.packageCount.backgroundColor = [UIColor whiteColor];
    
    self.packageDetail.text = [NSString stringWithFormat:@"/次 (%@小时) , %@次",model.packageSerHours,model.packageSerTimes];
    self.packageDetail.frame = CGRectMake(left(self.packageCount),y(self.packageDetail), [ZSize sizeWidth:self.packageDetail], h(self.packageDetail));
    self.packageDetail.backgroundColor = [UIColor whiteColor];
    
    self.packagePaymentLab.text = [NSString stringWithFormat:@"共%@次服务 合计:%@元",model.packageSerTimes,model.packageSinglePrice];
    self.packagePaymentLab.backgroundColor = [UIColor whiteColor];
    
}

-(void)fetchSubData:(SubOrderModel *)model{
    
    self.nameLab.text = model.consultantName;
    self.nameLab.backgroundColor = [UIColor whiteColor];
    
    self.packageTitle.text = model.packageTitle;
    self.packageTitle.backgroundColor = [UIColor whiteColor];
    
    self.packageCount.text = model.packageSinglePrice;
    self.packageCount.frame = CGRectMake(x(self.packageCount), y(self.packageCount),[ZSize sizeWidth:self.packageCount], h(self.packageCount));
    self.packageCount.backgroundColor = [UIColor whiteColor];
    
    self.packageDetail.text = [NSString stringWithFormat:@"/次 (%@小时) , %@次",model.packageSerHours,model.packageSerTimes];
    self.packageDetail.frame = CGRectMake(left(self.packageCount),y(self.packageDetail), [ZSize sizeWidth:self.packageDetail], h(self.packageDetail));
    self.packageDetail.backgroundColor = [UIColor whiteColor];
    
    self.packagePaymentLab.text = [NSString stringWithFormat:@"共%@次服务 合计:%@元",model.packageSerTimes,model.packageSinglePrice];
    self.packagePaymentLab.backgroundColor = [UIColor whiteColor];
    
}

//咨询订单页面
-(void)setConsultingOrdersCellStytle:(NSInteger)cellStytleCode{
    switch (cellStytleCode) {
        case 0:
        {
            self.cancelOrderBtn.hidden = NO;
            self.orderTypeLab.text = @"待支付";
            [self.wiatingPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
            
        }
            break;
        case 1:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"待咨询";
            [self.wiatingPayBtn setTitle:@"去咨询" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
            
        }
        case 2:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"待评价";
            [self.wiatingPayBtn setTitle:@"去评价" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
            
        }
            break;
        case 3:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"已评价";
            [self.wiatingPayBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            UIColor *color =Color_FA9E4B;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_FA9E4B forState:UIControlStateNormal];
            
        }
        case 4:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"已完成";
            [self.wiatingPayBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            UIColor *color =Color_FA9E4B;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_FA9E4B forState:UIControlStateNormal];
            
        }
            break;
        case 5:
        {
            self.cancelOrderBtn.hidden = YES;
            self.orderTypeLab.text = @"已关闭";
            [self.wiatingPayBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            UIColor *color =Color_FC5268;
            [self.wiatingPayBtn.layer setBorderColor:color.CGColor];
            [self.wiatingPayBtn setTitleColor:Color_FC5268 forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
