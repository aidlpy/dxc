//
//  MainTabbarVC.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MainTabbarVC.h"
#import "LoginViewController.h"

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
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 0.5)];
    lineView.backgroundColor = Color_F1F1F1;
    [self.tabBar addSubview:lineView];
    
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
            [vc.navigationController.navigationBar setHidden:YES];
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

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLoginVC:) name:PUSHLOGINVC object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPayPageAction:) name:@"addPayPage" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessfully:) name:@"paySuccessful" object:nil];
    
    
    

    
    
    
}

-(void)paySuccessfully:(NSNotification *)notification{
  
    NSDictionary *dic = [notification userInfo];
    NSString *chatterid = [dic objectForKey:@"emchat_username"];
    NSString *chatterNickName = [dic objectForKey:@"nickname"];
    NSString *chatterUserAdvatar = [dic objectForKey:@"avatar"];

    if (FetchToken != nil) {
        [[EMClient sharedClient] loginWithUsername:FetchEMUsername password:FetchEMPassword];
    }
    CacheChatReceiverAdvatar(chatterUserAdvatar);
    ChatWithPaymentVC *chatvc = [[ChatWithPaymentVC alloc] initWithConversationChatter:chatterid conversationType:EMConversationTypeChat];
    chatvc.friendNickName = chatterNickName;
    chatvc.hidesBottomBarWhenPushed = YES;
    MainTabbarVC *maintabbar = [self.navigationController.viewControllers copy][0];

    [maintabbar.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
   
        UINavigationController *nav = (UINavigationController *)obj;
        
        NSLog(@"viewControllers==>%@",_svc);
       
        if (idx == 2) {
          NSArray *array = [NSArray arrayWithObjects:nav.viewControllers[0],chatvc,_svc,nil];
          nav.viewControllers = array;
          chatvc.copynav = nav;
          [chatvc setNav];
        }
        else
        {
         NSArray *array=@[nav.viewControllers[0]];
             nav.viewControllers = array;
            
        }
    
    }];

                   
    self.selectedIndex = 2;
}

-(void)addPayPageAction:(NSNotification *)notification{
    NSDictionary *dic = [notification userInfo];
    NSString *orderType = [dic objectForKey:@"orderType"];
    _svc = [dic objectForKey:@"vc"];
    MainTabbarVC *maintabbar = [self.navigationController.viewControllers copy][0];
    [maintabbar.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        UINavigationController *nav = (UINavigationController *)obj;
        NSLog(@"_svc==>~%@",_svc);
        __block NSArray *array = nil;
        if (idx == 3) {
            if ([orderType integerValue] == 0)
            {
                ReservationOrderVController *reservc = [ReservationOrderVController new];
                reservc.hidesBottomBarWhenPushed = YES;
                array =@[nav.viewControllers[0],reservc,_svc];
            }
            else
            {
                ConsultingOrdersVController *consultvc = [ConsultingOrdersVController new];
                consultvc.hidesBottomBarWhenPushed = YES;
                array =@[nav.viewControllers[0],consultvc,_svc];
            }
           
        }
        else{
            
            array =@[nav.viewControllers[0]];
        }
       
        nav.viewControllers = array;
        
    }];
    self.selectedIndex = 3;
    
}






-(void)pushLoginVC:(NSNotification *)notification
{

    MainTabbarVC *maintabbar = [self.navigationController.viewControllers copy][0];
    [maintabbar.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UINavigationController *nav = (UINavigationController *)obj;
        NSArray *array =@[nav.viewControllers[0]];
        nav.viewControllers = array;
    }];
    
    [self setSelectedIndex:0];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

-(void)dealloc{
    
    
    
    
    
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
