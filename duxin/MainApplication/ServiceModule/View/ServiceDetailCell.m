//
//  ServiceDetailCell.m
//  duxin
//
//  Created by 37duxin on 03/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceDetailCell.h"

@implementation ServiceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(7,30,SIZE.width-14,30)];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.text = @"服务方向";
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_textView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(13, bottom(_textView)+6,SIZE.width-26,20)];
        _label.numberOfLines = 0;
        _label.backgroundColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14.0f];
        _label.backgroundColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        
    }
    return self;
}

-(void)updateUI:(ServiceDetailModel *)model{
    
    _label.text = model.serviceContent;
    CGSize size = [_label boundingRectWithSize:CGSizeMake(w(_label), 0)];
    [_label setMj_h:size.height];
    model.cellHeight = 60+size.height;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
