//
//  CounselorDetailVC.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CounselorDetailVC.h"


@interface CounselorDetailVC ()

@end

@implementation CounselorDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
}

-(void)initUI{
    self.navView.hidden = YES;
    UIView* stateView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SIZE.width, 20)];
    [self.navigationController.navigationBar addSubview:stateView];
    stateView.backgroundColor = [UIColor purpleColor];

    
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
