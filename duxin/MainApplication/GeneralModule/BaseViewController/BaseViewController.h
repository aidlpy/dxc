//
//  BaseViewController.h
//  mtm
//
//  Created by Albert on 18/01/2017.
//  Copyright © 2017 guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "CustomNavView.h"

@interface BaseViewController : UIViewController
@property(nonatomic,retain)CustomNavView *navView;
-(void)setStatusBarBackgroundColor:(UIColor *)color;
@end
