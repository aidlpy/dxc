//
//  PaySuccessfulViewController.h
//  duxin
//
//  Created by 37duxin on 04/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseViewController.h"

@interface PaySuccessfulViewController : BaseViewController
@property(nonatomic,copy)NSString *orderNumber;
@property(nonatomic,copy)NSString *typeString;
@property(nonatomic,retain)UIImageView *_imageView;
@property(nonatomic,retain)UILabel *_label;
@property(nonatomic,retain)UIButton *_button;
@property(nonatomic,retain)PaySuccessfulViewController *vc;

@end
