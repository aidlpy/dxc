//
//  ConsultingOrdersCell.h
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservatingCell.h"

@interface ConsultingOrdersCell : ReservatingCell
-(void)setConsultingSubOrderCell:(NSInteger)cellStytleCode;
-(void)fetchMainData:(ConsultingMainModel *)model;
-(void)fetchSubData:(SubOrderModel *)model;
-(void)setConsultingOrdersCellStytle:(NSInteger)cellStytleCode;
@end
