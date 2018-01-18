//
//  BaseViewController.m
//  mtm
//
//  Created by Albert on 18/01/2017.
//  Copyright © 2017 guest. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
//    _navView = [[CustomNavView alloc] init];
//    _navView.backgroundColor = [UIColor whiteColor];
//    __block typeof(self) weakSelf = self;
//    _navView.backBlock =^(){[weakSelf backTo];};
//    _navView.pushBlock = ^(){[weakSelf nextTo];};
//    [self.view addSubview:_navView];
    
 
    
}



-(void)nextTo{};
-(void)backTo{};
-(void)fetchURL:(NSString *)str{};
-(void)loadRequest{};

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
