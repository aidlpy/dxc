//
//  CommentCell.h
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CommentFooter.h"
#import "CWStarRateView.h"


@interface CommentCell : UITableViewCell
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *countLabl;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,retain)UILabel *commentLab;
@property(nonatomic,retain)UIImageView *headerImagView;
@property(nonatomic,retain)UILabel *replyCommentLabel;
@property(nonatomic,retain)CommentFooter *footerView;
@property(nonatomic,retain)CWStarRateView *startView;
@property(nonatomic,retain)UILabel *commentStringLab;

-(void)fillInCellFooter:(CommentModel *)model isReveration:(BOOL)isReveration;

@end
