//
//  ChatWithPaymentVC.m
//  duxin
//
//  Created by 37duxin on 25/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ChatWithPaymentVC.h"

@interface ChatWithPaymentVC ()

@end

@implementation ChatWithPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.copynav) {
        self.copynav.navigationBar.hidden = NO;
    }
    
    [self initUI];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.copynav.navigationBar.hidden = NO;
    if (self.navigationController.navigationBar) {
       [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
  
    
}

-(void)initUI{
    [self _setupBarButtonItem];
}

- (void)_setupBarButtonItem
{
    self.title = _friendNickName;
    [UINavigationBar appearance].translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:Color_5ECAF5] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self customStaus];

    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 19)];
    [leftBtn setImage:[UIImage imageNamed:Image(@"whiteLeftArrow")] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *leftNagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNagetiveSpacer.width = -5;

    self.navigationItem.leftBarButtonItems = @[leftNagetiveSpacer,leftBtnItem];
}

-(void)customStaus{
    
    CGFloat statusHeight = Height_StatusBar;
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0,0 - statusHeight,SIZE.width,statusHeight)];
    statusBarView.backgroundColor = Color_5ECAF5;
    [self.navigationController.navigationBar addSubview:statusBarView];
    
}


- (void)_sendMessage:(EMMessage *)message
    isNeedUploadFile:(BOOL)isUploadFile{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        EMMessageBody *msgBody = message.body;
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:message.to forKey:@"messageto"];
        [dic setObject:message.from forKey:@"messageform"];
        [dic setObject:FetchUserNickName forKey:@"formname"];
        [dic setObject:FetchUserHeaderImage forKey:@"formavatar"];
        
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                [dic setObject:@"0" forKey:@"messageType"];
                [dic setObject:txt forKey:@"messageval"];
                NSLog(@"收到的文字是 txt -- %@",txt);
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
                [dic setObject:@"1" forKey:@"messageType"];
                [dic setObject:body.remotePath forKey:@"messageval"];
                
                // 缩略图sdk会自动下载
                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                NSLog(@"纬度-- %f",body.latitude);
                NSLog(@"经度-- %f",body.longitude);
                NSLog(@"地址-- %@",body.address);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
                [dic setObject:@"2" forKey:@"messageType"];
                [dic setObject:body.remotePath forKey:@"messageval"];
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                
                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"视频的secret -- %@"        ,body.secretKey);
                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                
                // 缩略图sdk会自动下载
                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
                
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"文件的secret -- %@"        ,body.secretKey);
                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
            }
                break;
                
            default:
                break;
        }
        [self postEMMessage:dic];
    });
        
    [super _sendMessage:message isNeedUploadFile:isUploadFile];
   
}

-(void)postEMMessage:(NSMutableDictionary *)dic{
    NSLog(@"dic==>%@",dic);
    HttpsManager *httsmanager = [[HttpsManager alloc] init];
    [httsmanager postServerAPI:PostEMMessageToServer deliveryDic:dic successful:^(id responseObject) {
        NSLog(@"responseObject==>%@",responseObject);
        
    } fail:^(id error) {
        
    }];
    
    
    
}
-(void)setNav{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)backAction:(UIButton *)btn{
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
