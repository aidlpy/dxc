//
//  ReservationOrderVController.h
//  duxin
//
//  Created by 37duxin on 22/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_OPTIONS(NSInteger, OrderStatus) {
    WatingForOrderPay = 0,
    WatingForConsulting,
    WatingForComment,
    FinishComment,
    FinishOrderPay,
    AlreadColse,
    AllOrder =10000

};

@interface ReservationOrderVController : BaseViewController

@end
