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
    NSArray *_viewControllersArray;
    NSMutableArray *_viewControllers;
    NSArray *_tabbarTitleArray;
    NSArray *_tabbarImageArray;
    NSArray *_tabbarSelectedArray;
    
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
    
    _viewControllersArray=@[@"MainViewController",@"FoundViewController",@"ServiceViewController",@"MyViewController"];
    _tabbarTitleArray = @[@"首页",@"发现",@"服务",@"我的"];
    _tabbarImageArray = @[@"main",@"found",@"service",@"my"];
    _tabbarSelectedArray = @[@"mained",@"founded",@"serviced",@"myed"];
    _viewControllers = [[NSMutableArray alloc] initWithCapacity:0];
    
}

-(void)initTabbbar{
    
    self.tabBar.backgroundColor = [UIColor clearColor];
    [_viewControllersArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id viewController = nil;
        Class TabViewController = NSClassFromString(obj);
        if (TabViewController) {
            viewController = [[TabViewController alloc] init];
        }
        
        UIViewController *vc = ((UIViewController *)viewController);
        vc.title = _tabbarTitleArray[idx];
        
        //未选中之前的颜色
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] =[UIColor grayColor];
        
        //选中之后的颜色
        NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
        selectTextAttrs[NSForegroundColorAttributeName] = Color_5DCBF5;
        
        [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        
        vc.tabBarItem.image = [[UIImage imageNamed:Image(_tabbarImageArray[idx])] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:Image(_tabbarSelectedArray[idx])] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        [_viewControllers addObject:nav];
    }];
    self.viewControllers = [_viewControllers mutableCopy];
   
}

-(void)initUI{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UITabBar appearance].translucent = NO;
//    self.tabBar.tintColor = [UIColor clearColor];
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
