//
//  ServiceBtn.h
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface ServiceBtn : UIButton
@property(nonatomic,retain)UIImageView *logoImageView;
@property(nonatomic,retain)UILabel *titleLab;
-(void)setImage:(NSString *)imageStr setTitle:(NSString *)string;
@end
