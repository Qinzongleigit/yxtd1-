//
//  GeRenZiLiaoViewController.m
//  yxtd
//
//  Created by qin on 2017/11/17.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "GeRenZiLiaoViewController.h"
#import "SexView.h"
#import "NickNameView.h"
#import "UpdatePhoneNumberViewController.h"
#import "ShipAddressViewController.h"

#import "UpdatePhoneNumberViewController.h"


#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

typedef NS_ENUM(NSInteger, ChosePhontType) {
    
    ChosePhontTypeAlbum,  //相册
    ChosePhontTypeCamera   //相机
};

@interface GeRenZiLiaoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) NSArray*nameArr;
@property (nonatomic,strong) SexView*sexView;
@property (nonatomic,strong) NickNameView*nickVc;
@property (nonatomic,strong) UIButton*sexBt;
@property (nonatomic,strong) UILabel*nameLabel;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;


@property (nonatomic,strong) UILabel*phoneLabel;

@end

@implementation GeRenZiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self setExtraCellLineHidden:self.tableView];
    
    self.title=@"个人资料";
    
    //左边按钮
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem=leftBt;

    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    _nameArr=@[@"头像",@"昵称",@"性别",@"城市"
               ];
    
    [self.view addSubview:self.tableView];
    
}

//导航栏左边返回按钮点击事件
-(void)backBtn{
    

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -创建表格视图
-(UITableView*)tableView{
    if (!_tableView) {
        UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH)];
        self.tableView=tableView;
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
        ///行高
        tableView.rowHeight=60;
    }

    return _tableView;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!section) {
        
        return 4;
    }else {
        
    return 1;
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*cellID=@"id";
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    UIImageView*imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cee_rightImage"]];
    [cell.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.right.equalTo(cell.contentView).with.offset(-15);
    }];
    
    
    if (!indexPath.section) {
        
        cell.textLabel.text=_nameArr[indexPath.row];
        
        if (!indexPath.row) {
            
            //设置第0行头像
            UIImageView *imageView = [[UIImageView alloc] init];
            
          _iconView = imageView;
            _iconView.backgroundColor=[UIColor redColor];
           // [imageView sd_setImageWithURL:[NSURL URLWithString:_messageArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"yonghutouxiang"]];
            
            imageView.layer.cornerRadius = 15;
            imageView.clipsToBounds = YES;
            [cell addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.mas_right).with.offset(-40);
                make.size.mas_equalTo(CGSizeMake(30, 30));
                
            }];
            
        }else if (indexPath.row==1) {
            
            //名字
            UILabel*nameLabel=[[UILabel alloc] init];
            nameLabel.text=@"骑猪去放牛";
            self.nameLabel=nameLabel;
            nameLabel.font=[UIFont systemFontOfSize:12];
            nameLabel.textColor=BlackHexColor;
            nameLabel.userInteractionEnabled=YES;
          
            [cell.contentView addSubview:nameLabel];
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.mas_right).with.offset(-40);
            }];
            
            UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTap)];
            tap.numberOfTapsRequired=1;
            tap.numberOfTouchesRequired=1;
            [nameLabel addGestureRecognizer:tap];

            
        }else if (indexPath.row==2){
            
            //性别
            UIButton*sexBt=[UIButton buttonWithType:UIButtonTypeCustom];
            [sexBt setTitle:@"男" forState:UIControlStateNormal];
            [sexBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.sexBt=sexBt;
            sexBt.titleLabel.font=[UIFont systemFontOfSize:12];
           [sexBt addTarget:self action:@selector(sexBtClick) forControlEvents:UIControlEventTouchUpInside];

            [cell.contentView addSubview:sexBt];
            
            [sexBt mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.mas_right).with.offset(-40);
            }];
            
        }
        
    }else if (indexPath.section==1){
        
        cell.textLabel.text=@"手机";
        
        
       //手机号
        UILabel*phoneLabel=[[UILabel alloc] init];
        
        phoneLabel.text=[self numberSuitScanf:@"15817370052"];
        self.phoneLabel=phoneLabel;
        phoneLabel.font=[UIFont systemFontOfSize:12];
        phoneLabel.textColor=BlackHexColor;
        [cell.contentView addSubview:phoneLabel];
        
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.mas_right).with.offset(-40);
        }];
        
    }else{
        cell.textLabel.text=@"发货地址";
    }
    cell.textLabel.textColor=BlackHexColor;
    
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    
     //点击单元格单元格显示的背景样式
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


#pragma mark-昵称修改点击事件
-(void)nameTap{

    NickNameView*nickVc=[[NickNameView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH)];
    self.nickVc=nickVc;
    [[UIApplication sharedApplication].keyWindow addSubview:self.nickVc];
    nickVc.nickNameBlock = ^(NSString *nickName) {
      
    
        self.nameLabel.text=nickName;

        [self.nickVc removeFromSuperview];
        
        self.nickVc=nil;
    };
    
}

#pragma mark -性别按钮点击事件
-(void)sexBtClick{
    
   
  SexView*sexView=[[SexView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH)];
    self.sexView=sexView;
      [[UIApplication sharedApplication].keyWindow addSubview:self.sexView];
    
    
    //性别改动回调
    sexView.sexBtClick = ^(NSInteger tag) {
        
        [self.sexView removeFromSuperview];
        self.sexView=nil;
        
        if (!tag) {
            
            [self.sexBt setTitle:@"男" forState:UIControlStateNormal];
            
            
        }else if (tag==1){
            
            [self.sexBt setTitle:@"女" forState:UIControlStateNormal];
         
        }
    };


}


#pragma mark-手机号验证和隐藏中间号码
-(NSString *)numberSuitScanf:(NSString*)number{
    
    //验证是不是手机号码
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];

    BOOL isOk = [phoneTest evaluateWithObject:number];
    
    if (isOk) {//如果是手机号码的话
        
        //隐藏中间6位
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];

        return numberString;
        
    }
    
    return number;
    
}


//设置段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section!=2) {
        
       return 12;
        
    }
    return 0;
}
//组尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section!=2) {
        UIView*footerView=[[UIView alloc] init];
        footerView.backgroundColor=btnLineColor;
        
        return footerView;
    }
   
    return nil;
    
}

#pragma mark -表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (!indexPath.section) {
        
        if (!indexPath.row) {
         //头像图片选择
            UIImagePickerController*imagePicker=[[UIImagePickerController alloc] init];
            imagePicker.delegate=self;
            self.imagePicker=imagePicker;
            [imagePicker setAllowsEditing:YES];
            
            
            UIAlertController*alter=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction*cancleAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction*cameraAction=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
              [self cameraOpen];
              
                
            }];
            
           
            
            UIAlertAction*photoAction=[UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
               [self photoOpen];
              
                
            }];
            
            [alter addAction:cancleAction];
            [alter addAction:cameraAction];
            [alter addAction:photoAction];
            
            [self presentViewController:alter animated:YES completion:nil];
                                     
            
        }
    }else if (indexPath.section==1){ //修改手机号
        
        
    UpdatePhoneNumberViewController*updatePhoneVC=[[UpdatePhoneNumberViewController alloc] init];
        
        [self.navigationController pushViewController:updatePhoneVC animated:YES];
        
        //修改手机号回调回来的数据
        updatePhoneVC.gotoGeRenZiLiao = ^(NSString *phoneNumber) {
          
            self.phoneLabel.text=[self numberSuitScanf:phoneNumber];
        };
        
    }else{ //发货地址
        
        ShipAddressViewController*shipAddVC=[[ShipAddressViewController alloc] init];
        
        [self.navigationController pushViewController:shipAddVC animated:nil];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark-图库(ios 11默认打开相册的读权限，11之前还是要判断权限是否打开)
-(void)photoOpen{

    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        //======判断 访问相册 权限是否开启=======
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
       
        //有被授权访问的照片数据   用户已经明确否认了这一照片数据的应用程序访问
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //====没有权限====
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去开启访问相册权限?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                //===无权限 引导去开启===
                [self openJurisdiction];
            }];
            // 将UIAlertAction添加到UIAlertController中
            [alertController addAction:cancel];
            [alertController addAction:ok];
            // present显示
            [self presentViewController:alertController animated:YES completion:nil];
        }else{    //====有访问相册的权限=======
            
            //支持图库
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
        
        
        //图库打不开
    }else{
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"友情提示"message:@"你的图库不能打开"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
    }
    
}

#pragma mark-相机
-(void)cameraOpen{
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        //======判断 访问相机 权限是否开启=======
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        //===无权限====
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            //====没有权限====
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去开启访问相机权限?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                //===无权限 引导去开启===
                [self openJurisdiction];
            }];
            
            // 将UIAlertAction添加到UIAlertController中
            [alertController addAction:cancel];
            [alertController addAction:ok];
            // present显示
            [self presentViewController:alertController animated:YES completion:nil];
        }else{  //===有权限======
            //相机可用
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
        
        //不能使用
    }else {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"友情提示"message:@"请检查你的摄像头是否完好"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
        
        
    }
    
    
 
}
    
    


#pragma mark-------去设置界面开启权限----------
-(void)openJurisdiction{
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
       // [[UIApplication sharedApplication] openURL:url];
        
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

#pragma mark - imagePicker代理

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image=info[@"UIImagePickerControllerEditedImage"];
    
    UIImage *sacleImage = [self scaleToSize:image size:CGSizeMake(160, 160)];
    
    self.iconView.image = sacleImage;
    
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *imgData = UIImageJPEGRepresentation(sacleImage, 0.7);
    
    /**
     *  base64编码
     */
    NSString *touimg = [imgData base64EncodedStringWithOptions:0];
    
    //头像上传网络请求
   // [self httpToUploadIconWithIconStr:touimg];
}


#pragma mark - 压缩成指定大小的图片
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    //返回新的改变大小后的图片
    return scaledImage;
}


#pragma mark- 隐藏多余的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}



@end
