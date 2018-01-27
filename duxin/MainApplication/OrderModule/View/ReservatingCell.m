//
//  ReservatingCell.m
//  duxin
//
//  Created by 37duxin on 26/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservatingCell.h"
#import "TagView.h"

@implementation ReservatingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (!_tagViewArray) {
            _tagViewArray = [[NSMutableArray alloc] init];
        }
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10,23, 55, 16)];
        _titleLab.textColor = Color_2A2A2A;
        _titleLab.font = [UIFont systemFontOfSize:15.0f];
        _titleLab.text = @"咨询师:";
        [self addSubview:_titleLab];
        
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(left(_titleLab)+5, 0, 200,20)];
        _nameLab.backgroundColor = Color_F1F1F1;
        _nameLab.center = CGPointMake(_nameLab.center.x,_titleLab.center.y);
        _nameLab.textColor = Color_5ECAF7;
        [self addSubview:_nameLab];
        
        _orderTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-75, 0, 65, 12.5)];
        _orderTypeLab.textAlignment = NSTextAlignmentRight;
        _orderTypeLab.center = CGPointMake(_orderTypeLab.center.x, _titleLab.center.y);
        _orderTypeLab.font = _titleLab.font;
        _orderTypeLab.textColor =Color_3A3A3A;
        [self addSubview:_orderTypeLab];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, bottom(_titleLab)+6,SIZE.width,1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
        _packageTitle = [[UILabel alloc] initWithFrame:CGRectMake(13,bottom(_lineView)+15,SIZE.width-110, 20)];
        _packageTitle.backgroundColor = Color_F1F1F1;
        _packageTitle.textColor = Color_1F1F1F;
        _packageTitle.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_packageTitle];
        
        _packageCount = [[UILabel alloc] initWithFrame:CGRectMake(13,bottom(_packageTitle)+9,20, 20)];
        _packageCount.backgroundColor = Color_F1F1F1;
        _packageCount.textColor = Color_5ECAF7;
        _packageCount.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_packageCount];
        
        _packageDetail = [[UILabel alloc] initWithFrame:CGRectMake(left(_packageCount)+9,0,100,20)];
        _packageDetail.backgroundColor = Color_F1F1F1;
        _packageDetail.textColor = Color_BABABA;
        _packageDetail.center = CGPointMake(_packageDetail.center.x, _packageCount.center.y+1);
        _packageDetail.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:_packageDetail];
        
        NSArray *array = @[@{@"image":@"certification",@"title":@"资质认证"},@{@"image":@"transactionGuarantee",@"title":@"交易担保"},@{@"image":@"refund",@"title":@"不满意退款"}];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = (NSDictionary *)obj;
            TagView *tagView = [[TagView alloc] initWithFrame:CGRectMake(13+idx*85,bottom(_packageCount)+15, 85,17)];
            [tagView.headerImagV setImage:[UIImage imageNamed:Image([dic objectForKey:@"image"])]];
            [tagView.titleLab setText:[dic objectForKey:@"title"]];
            tagView.backgroundColor = [UIColor whiteColor];
            [self addSubview:tagView];
            [_tagViewArray addObject:tagView];
        }];
        array = nil;
        
        _packagePaymentLab = [[UILabel alloc] initWithFrame:CGRectMake(0,bottom(_tagViewArray.lastObject)+25,SIZE.width-12.5,20)];
        _packagePaymentLab.textAlignment = NSTextAlignmentRight;
        _packagePaymentLab.textColor = Color_1F1F1F;
        _packagePaymentLab.font = [UIFont systemFontOfSize:14.0f];
        _packagePaymentLab.backgroundColor = Color_F1F1F1;
        [self addSubview:_packagePaymentLab];
        
        _wiatingPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-90,bottom(_packagePaymentLab)+9, 80, 28)];
        _wiatingPayBtn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        UIColor *color = Color_5ECAF7;
        [_wiatingPayBtn.layer setBorderColor:color.CGColor];
        [_wiatingPayBtn.layer setCornerRadius:4.0f];
        [_wiatingPayBtn.layer setBorderWidth:1.0f];
        [_wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
        [_wiatingPayBtn addTarget:self action:@selector(generalAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_wiatingPayBtn];
        
        _cancelOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-180,bottom(_packagePaymentLab)+9, 80, 28)];
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        UIColor *color1 = Color_FDA8AF;
        [_cancelOrderBtn.layer setBorderColor:color1.CGColor];
        [_cancelOrderBtn.layer setCornerRadius:4.0f];
        [_cancelOrderBtn.layer setBorderWidth:1.0f];
        [_cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelOrderBtn setTitleColor:Color_FDA8AF forState:UIControlStateNormal];
        _cancelOrderBtn.hidden = YES;
        [_cancelOrderBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelOrderBtn];
        
    }
    return  self;
    
}

-(void)cancelOrder:(UIButton *)sender{
    _cancelBlock(self.tag);
}

-(void)generalAction:(UIButton *)sender{
    _generalBlock(self.tag);
}


//预定订单页面
-(void)setCellStytle:(NSInteger)cellStytleCode{
    switch (cellStytleCode) {
        case 0:
        {
            _cancelOrderBtn.hidden = NO;
            _orderTypeLab.text = @"待支付";
            [_wiatingPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [_wiatingPayBtn.layer setBorderColor:color.CGColor];
            [_wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
        
        }
            break;
        case 2:
        {
            _cancelOrderBtn.hidden = YES;
            _orderTypeLab.text = @"待评价";
            [_wiatingPayBtn setTitle:@"待评价" forState:UIControlStateNormal];
            UIColor *color = Color_5ECAF7;
            [_wiatingPayBtn.layer setBorderColor:color.CGColor];
            [_wiatingPayBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
            
        }
            break;
        case 3:
        {
            _cancelOrderBtn.hidden = YES;
            _orderTypeLab.text = @"已完成";
            [_wiatingPayBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            UIColor *color =Color_FA9E4B;
            [_wiatingPayBtn.layer setBorderColor:color.CGColor];
            [_wiatingPayBtn setTitleColor:Color_FA9E4B forState:UIControlStateNormal];
            
        }
        case 4:
        {
            _cancelOrderBtn.hidden = YES;
            _orderTypeLab.text = @"已完成";
            [_wiatingPayBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            UIColor *color =Color_FA9E4B;
            [_wiatingPayBtn.layer setBorderColor:color.CGColor];
            [_wiatingPayBtn setTitleColor:Color_FA9E4B forState:UIControlStateNormal];
            
        }
            break;
        case 5:
        {
            _cancelOrderBtn.hidden = YES;
            _orderTypeLab.text = @"已关闭";
             [_wiatingPayBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            UIColor *color =Color_FC5268;
            [_wiatingPayBtn.layer setBorderColor:color.CGColor];
            [_wiatingPayBtn setTitleColor:Color_FC5268 forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}




-(void)fetchData:(OrderModel *)model{
    
    _nameLab.text = model.consultantName;
    _nameLab.backgroundColor = [UIColor whiteColor];
    
    _packageTitle.text = model.packageTitle;
    _packageTitle.backgroundColor = [UIColor whiteColor];
    
    _packageCount.text = model.packageSinglePrice;
    _packageCount.frame = CGRectMake(x(_packageCount), y(_packageCount),[ZSize sizeWidth:_packageCount], h(_packageCount));
    _packageCount.backgroundColor = [UIColor whiteColor];
    
    _packageDetail.text = [NSString stringWithFormat:@"/次 (%@小时) , %@次",model.packageSerHours,model.packageSerTimes];
    _packageDetail.frame = CGRectMake(left(_packageCount),y(_packageDetail), [ZSize sizeWidth:_packageDetail], h(_packageDetail));
    _packageDetail.backgroundColor = [UIColor whiteColor];
    
    _packagePaymentLab.text = [NSString stringWithFormat:@"共%@次服务 合计:%@元",model.packageSerTimes,model.packageSinglePrice];
    _packagePaymentLab.backgroundColor = [UIColor whiteColor];
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
