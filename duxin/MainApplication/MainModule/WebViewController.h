//
//  WebViewController.h
//  duxin
//
//  Created by Zhang Xinrong on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)NSString *urlString;
@end
