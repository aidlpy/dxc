//
//  CommentFooter.h
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentFooter : UIView
@property(nonatomic,retain)UIImageView *headerImageView;
@property(nonatomic,retain)UILabel *textLabel;
-(void)updateUI:(CommentModel *)model;
@end
