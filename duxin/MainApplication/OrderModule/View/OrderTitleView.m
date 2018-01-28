//
//  OrderTitleView.m
//  duxin
//
//  Created by 37duxin on 24/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderTitleView.h"



@implementation OrderTitleView

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
   self = [super initWithFrame:frame];
    if (self) {
        if (array.count != 0) {
            
            _btnArray = [[NSMutableArray alloc] initWithCapacity:0];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
                CGFloat x = SIZE.width/(2*array.count);
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,2*x,self.frame.size.height-1)];
                btn.center = CGPointMake(x+idx*2*x, btn.center.y);
                btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
                [btn setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
                [btn setTitle:obj forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(slideMove:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = idx;
                [self addSubview:btn];
                [_btnArray addObject:btn];
                
            }];
            
            _linebackView = [[UIView alloc] initWithFrame:CGRectMake(0,((UIButton *)_btnArray.lastObject).frame.size.height, SIZE.width, 1)];
            _linebackView.backgroundColor = Color_DCDCDC;
            [self addSubview:_linebackView];
            
            _SlideView  = [[UIButton alloc] initWithFrame:CGRectMake(0, ((UIButton *)_btnArray.lastObject).frame.size.height-1, SIZE.width/_btnArray.count,2)];
            _SlideView.backgroundColor = Color_5ECAF7;
            [self addSubview:_SlideView];
        }
    
    }
    return self;
}

-(void)slideMove:(UIButton *)slideBtn{
    _indexBlock(slideBtn.tag);
    
    [_SlideView.layer removeAllAnimations];
    CGFloat x = SIZE.width/(2*_btnArray.count);
    [UIView animateWithDuration:0.3 animations:^{
        _SlideView.center = CGPointMake(x+slideBtn.tag*2*x, _SlideView.center.y);
    } completion:^(BOOL finished) {
        _SlideView.center = CGPointMake(x+slideBtn.tag*2*x, _SlideView.center.y);
        
    }];
    

}

@end
