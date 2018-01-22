//
//  ReservationOrderVController.m
//  duxin
//
//  Created by 37duxin on 22/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservationOrderVController.h"

@interface ReservationOrderVController ()

@end

@implementation ReservationOrderVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"预约订单" rightImage:@"whiteLeftArrow"];
}

-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
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
