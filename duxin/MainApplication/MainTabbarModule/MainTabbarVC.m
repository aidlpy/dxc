//
//  MainTabbarVC.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MainTabbarVC.h"

@interface MainTabbarVC ()
{
    NSInteger _switchIndex;
    NSArray *_kindsTitle;//分类Title数组
    
}

@end

@implementation MainTabbarVC


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
        [self initTabbbar];
        [self initUI];
        
    }
    return self;
}

-(void)initData{
    _switchIndex= 0;
    _kindsTitle = @[];
    
    
}

-(void)initTabbbar{
    
}

-(void)initUI{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
