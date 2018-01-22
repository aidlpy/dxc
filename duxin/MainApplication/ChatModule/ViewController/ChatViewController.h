//
//  ChatViewController.h
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"


@interface ChatViewController : HDMessageViewController<HDMessageViewControllerDelegate, HDMessageViewControllerDataSource>

@property (strong, nonatomic) NSDictionary *commodityInfo; //产品信息

@property(nonatomic,retain)NSString *navTitle;

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

- (void)userAccountDidLoginFromOtherDevice;

@end
