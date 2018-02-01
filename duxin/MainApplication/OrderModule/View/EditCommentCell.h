//
//  EditCommentCell.h
//  duxin
//
//  Created by 37duxin on 29/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"


typedef void (^fetchPercentBlock)(CGFloat startNumber);
typedef void (^postCommentBlock) (CGFloat startNumber);

@interface EditCommentCell : UITableViewCell<UITextViewDelegate,CWStarRateViewDelegate>
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)CustomTextView *textView;
@property(nonatomic,retain)UIImageView *selectedImageView;
@property(nonatomic,retain)UIButton *selectedBtn;
@property(nonatomic,copy)fetchPercentBlock fetchPercentBlock;
@property(nonatomic,copy)postCommentBlock postCommentBlock;
@property(nonatomic,retain)CWStarRateView *stars;
@end
