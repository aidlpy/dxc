//
//  MyCollectionVC.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyCollectionVC.h"

@interface MyCollectionVC ()

@end

@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"我的收藏" rightImage:@"whiteLeftArrow"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,h(self.navView)+58, 120, 120)];
    imageView.center = CGPointMake(SIZE.width/2,imageView.center.y);
    [imageView setImage:[UIImage imageNamed:Image(@"noCollection")]];
    [self.view addSubview:imageView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, bottom(imageView)+17, 100, 20)];
    titleLab.center = CGPointMake(imageView.center.x, titleLab.center.y);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = Color_D4D4D4;
    titleLab.text = @"还没有收藏";
    titleLab.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:titleLab];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
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
