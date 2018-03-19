//
//  PaymentViewController.h
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseViewController.h"
#import "PayCell.h"
#import "ConsultingMainModel.h"

@interface PaymentViewController : BaseViewController
@property(nonatomic,retain)NSString *orderId;
@property(nonatomic,retain)NSString *orderPrice;
@property(nonatomic,retain)NSString *orderDetail;
@property(nonatomic,assign)BOOL iSCreated;
@property(nonatomic,retain)NSString *orderTitle;
@end
