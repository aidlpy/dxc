//
//  ChatWithPaymentVC.h
//  duxin
//
//  Created by 37duxin on 25/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "EaseMessageViewController.h"

@interface ChatWithPaymentVC : EaseMessageViewController
@property(nonatomic,copy)NSString *friendNickName;
@property(nonatomic,copy)NSString *friendId;
@property(nonatomic,retain)UINavigationController *copynav;

-(void)setNav;
@end
