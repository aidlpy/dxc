//
//  MyInfoViewController.m
//  duxin
//
//  Created by 37duxin on 23/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyInfoViewController.h"
#import "AccountSafeCell.h"
#import "HeaderImageCell.h"

@interface  MyInfoViewController()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray  *_dataArray;
    NSData *_yadata;
    UIImage *_image;
    
    
    
}
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    initData(self);
    [self initUI];
}

void initData(MyInfoViewController *vc){
    
    
    NSString *headerImage = FetchUserHeaderImage;
    NSString *nickName = FetchUserNickName;
    NSString *sex =  FetchUserSex;
    vc->_dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *dic0 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"头像",@"title",headerImage,@"content",nil];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"昵称",@"title",nickName,@"content",nil];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"性别",@"title",sex,@"content",nil];
    [vc->_dataArray  addObject:dic0];
    [vc->_dataArray  addObject:dic1];
    [vc->_dataArray  addObject:dic2];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"个人资料" rightImage:@"whiteLeftArrow"];
    
    //设置列表属性
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, SIZE.height-h(self.navView)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [self fetchUITableViewFooterView];
    [self.view addSubview:_tableView];
    
}

-(UIView *)fetchUITableViewFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,150.0f)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20,0, SIZE.width-40,40)];
    button.center = footerView.center;
    button.backgroundColor = self.navView.backgroundColor;
    [button.layer setCornerRadius:2.0f];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(postPersonalInfo) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    return footerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    if (indexPath.row == 0) {
        
        static NSString *headerImageID = @"headerImageID";
        HeaderImageCell *cell = [tableView dequeueReusableCellWithIdentifier:headerImageID];
        if (cell == nil) {
            cell = [[HeaderImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerImageID]
            ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.titleLab.text = dic[@"title"];
        [cell.lineView setOriginX:20];
        [cell.lineView setWidth:SIZE.width-20];
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"content"]]];
        
        return cell;
    }
    else
    {
        static NSString *TextCellId = @"TextCellId";
        AccountSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellId];
        if (cell == nil) {
            cell = [[AccountSafeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextCellId]
            ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.titleLab.text = dic[@"title"];
        [cell.lineView setOriginX:20];
        [cell.lineView setWidth:SIZE.width-20];
        if (indexPath.row == 2) {
            cell.descributionLab.text =[dic[@"content"] isEqualToString:@"1"]?@"男":@"女";
        }else{
            cell.descributionLab.text =dic[@"content"];
        }
     
        return cell;
    }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            [self showActionSheet];
            
        }
            break;
            
        case 1:
        {
            [self modifyNickName];
            
        }
            break;
        case 2:
        {
            [self showSexAction];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)showActionSheet
{
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self localPhoto];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:camera];
    [AlertSelect addAction:photo];
    [AlertSelect addAction:cancelAction];
    
    [self presentViewController:AlertSelect animated:YES completion:nil];
    
}

-(void)modifyNickName{
    
    __block UITextField *textFild;
    UIAlertController  *alertView= [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dic = _dataArray[1];
        [dic setObject:textFild.text forKey:@"content"];
        [_tableView reloadData];
    }];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入昵称";
        textFild = textField;
    }];
    [self presentViewController:alertView animated:YES completion:nil];
    
    
}

-(void)showSexAction{
    
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dic = _dataArray[2];
        [dic setObject:@"1" forKey:@"content"];
        [_tableView reloadData];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dic = _dataArray[2];
        [dic setObject:@"2" forKey:@"content"];
        [_tableView reloadData];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:camera];
    [AlertSelect addAction:photo];
    [AlertSelect addAction:cancelAction];
    [self presentViewController:AlertSelect animated:YES completion:nil];
}



-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        
    {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:NO completion:nil];
        
    }
    else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


-(void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //先把图片转成NSData
            _image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            _yadata =UIImageJPEGRepresentation(_image,0.6f);
            [self postPhoto:_yadata];
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)postPhoto:(NSData *)data{

    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"type"];
    [httpsManager postServerAPI:postImageURL Paramater:dic data:data name:@"touxiang.jpg" andContentType:@"image/jpeg" successful:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] ==200) {
            _yadata = nil;
            _image=nil;
            NSDictionary *dataDic = [dic objectForKey:@"data"];
            
            if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
                
                NSString *url = [dataDic objectForKey:@"url"];
                NSMutableString *mutableString = [NSMutableString stringWithString:url];
                NSString *currentString = [mutableString stringByReplacingOccurrencesOfString:@"-internal" withString:@""];
                NSDictionary *cellDic = _dataArray[0];
                [cellDic setValue:currentString forKey:@"content"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }
            else{
                [self errorwarning];
            }
        }
        
    } fail:^(id error) {
            _yadata = nil;
            _image = nil;
            [self errorwarning];
    }];
}

-(void)postPersonalInfo{
    
    HttpsManager *httpmanager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[_dataArray[0] objectForKey:@"content"]  forKey:@"avatar"];
    [dic setObject:[_dataArray[1] objectForKey:@"content"] forKey:@"nickname"];
    if ([[_dataArray[2] objectForKey:@"content"] integerValue] != 0) {
        [dic setObject:[_dataArray[2] objectForKey:@"content"] forKey:@"gender"];
    }
    [httpmanager postServerAPI:postModifyPersonalInfo deliveryDic:dic  successful:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"responseObject==%@",responseObject);
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            if ([[dataDic objectForKey:@"code"] integerValue] ==200) {
                NSDictionary *resultDic = [dataDic objectForKey:@"data"];
                if ([[resultDic objectForKey:@"error_code"] integerValue] == 0)
                {
                    if ([dic objectForKey:@"avatar"]) {
                        CacheUserHeaderImage([dic objectForKey:@"avatar"]);
                    }
                    if ([dic objectForKey:@"nickname"]) {
                        CacheUserNickName([dic objectForKey:@"nickname"]);
                    }
                    if ([dic objectForKey:@"gender"]) {
                        CacheUserSex([dic objectForKey:@"gender"]);
                    }
                    
                    NSNotification *notification =[NSNotification notificationWithName:LOGINUPDATE object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                   
                        [SVHUD showErrorWithDelay:@"修改成功!" time:0.8f];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                else
                {
                    [self errorwaringInfo];
                    
                }
            }
            else
            {
                [self errorwaringInfo];
            }
            
        });
     
    } fail:^(id error) {
        [self errorwaringInfo];
    }];
}

-(void)errorwaringInfo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"" time:0.8f];
    });
    
}



-(void)errorwarning{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"选择照片失败" time:0.8];
    });
    
}
    

-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
