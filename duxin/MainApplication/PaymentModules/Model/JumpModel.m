//
//  JumpModel.m
//  duxin
//
//  Created by 37duxin on 04/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "JumpModel.h"


@implementation JumpModel
//+(void)addLoadPayPage:(UINavigationController *)nav with:(NSString *)tn type:(NSString *)typeString from:(NSInteger)isFromPath{
//
//    PaySuccessfulViewController *vc = [[PaySuccessfulViewController alloc] init];
//    vc.tnString = tn;
//    vc.typeString = typeString;
//    vc.isfromPath = isFromPath;
//    NSMutableArray *controllerArray = [nav.viewControllers mutableCopy];
//    [controllerArray replaceObjectAtIndex:controllerArray.count-1 withObject:vc];
//    nav.viewControllers = controllerArray;
//}

//+(void)jumpModel:(NSString *)string{
//
//
//
//}

//+(void)initSuccessfullyNavigation:(UINavigationController *)nav with:(NSString *)emchatusername from:(NSInteger)isFromPath{
//
//    MainTabbarVC *mainVc = (MainTabbarVC *)nav.navigationController.viewControllers[0];
//
//    UINavigationController *mainNav = mainVc.viewControllers[0];
//    NSArray *mainArray = [[NSMutableArray alloc] initWithObjects:mainNav.viewControllers[0],nil];
//    mainNav.viewControllers = mainArray;
//
//    UINavigationController *foundNav = mainVc.viewControllers[1];
//    NSArray *foundArray = [[NSMutableArray alloc] initWithObjects:foundNav.viewControllers[0],nil];
//    foundNav.viewControllers = foundArray;
//
//    UINavigationController *serviceNav = mainVc.viewControllers[2];
//    ChatWithPaymentVC *chatVC = [[ChatWithPaymentVC alloc] initWithConversationChatter:emchatusername conversationType:EMConversationTypeChat];
//    [chatVC.navigationController.navigationBar setHidden:NO];
//    chatVC.hidesBottomBarWhenPushed = YES;
//
//    UINavigationController *myNav = mainVc.viewControllers[3];
//    NSArray *myArray = [[NSMutableArray alloc] initWithObjects:myNav.viewControllers[0], nil];
//
//    __block PaySuccessfulViewController *sucessfulVC = nil;
//    if (isFromPath == 2) {
//        sucessfulVC  = serviceNav.viewControllers.lastObject;
//        sucessfulVC.hidesBottomBarWhenPushed = YES;
//    }
//    else if(isFromPath == 3){
//        sucessfulVC  = myNav.viewControllers.lastObject;
//        sucessfulVC.hidesBottomBarWhenPushed = YES;
//
//    }
//    else
//    {
//        nil;
//
//    }
//
//    NSArray *serviceArray = nil;
//    if (chatVC != nil) {
//        serviceArray = [[NSMutableArray alloc] initWithObjects:serviceNav.viewControllers[0],chatVC,sucessfulVC ,nil];
//    }
//    else{
//        serviceArray = [[NSMutableArray alloc] initWithObjects:serviceNav.viewControllers[0],sucessfulVC ,nil];
//    }
//    serviceNav.viewControllers = serviceArray;
//    myNav.viewControllers = myArray;
//    [mainVc setSelectedIndex:2];
//
//}

//+(void)initFailAndCancelPayNavigation:(UINavigationController *)nav type:(NSString *)type from:(NSInteger)isFromPath{
//    
//    MainTabbarVC *mainVc = (MainTabbarVC *)nav.navigationController.viewControllers[0];
//    
//    UINavigationController *mainNav = mainVc.viewControllers[0];
//    NSArray *mainArray = [[NSMutableArray alloc] initWithObjects:mainNav.viewControllers[0],nil];
//    mainNav.viewControllers = mainArray;
//    
//    UINavigationController *foundNav = mainVc.viewControllers[1];
//    NSArray *foundArray = [[NSMutableArray alloc] initWithObjects:foundNav.viewControllers[0],nil];
//    foundNav.viewControllers = foundArray;
//    
//    UINavigationController *serviceNav = mainVc.viewControllers[2];
//    
//    UINavigationController *myNav = mainVc.viewControllers[3];
//    
//    __block PaySuccessfulViewController *sucessfulVC = nil;
//    if (isFromPath == 2) {
//        sucessfulVC = serviceNav.viewControllers.lastObject;
//    }
//    else
//        if (isFromPath ==3) {
//            sucessfulVC = myNav.viewControllers.lastObject;
//        }
//        else{
//            
//        
//    }
//
//    PaySuccessfulViewController *paysuccess = [[PaySuccessfulViewController alloc] init];
//    paysuccess.hidesBottomBarWhenPushed = YES;
//    paysuccess.tnString = sucessfulVC.tnString;
//    paysuccess.typeString = sucessfulVC.typeString;
//    
//    NSArray *serviceArray = [[NSMutableArray alloc] initWithObjects:serviceNav.viewControllers[0],nil];
//    serviceNav.viewControllers = serviceArray;
//    
//    __block NSArray *myArray = nil;
//    if ([type isEqualToString:@"0"]) {
//        ReservationOrderVController *vc = [[ReservationOrderVController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        myArray = [[NSMutableArray alloc] initWithObjects:myNav.viewControllers[0],vc,paysuccess,nil];
//    }
//    else{
//        ConsultingOrdersVController *vc = [[ConsultingOrdersVController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        myArray = [[NSMutableArray alloc] initWithObjects:myNav.viewControllers[0],vc,paysuccess,nil];
//    }
//    myNav.viewControllers = myArray;
//    [mainVc setSelectedIndex:3];
//
//}



@end
