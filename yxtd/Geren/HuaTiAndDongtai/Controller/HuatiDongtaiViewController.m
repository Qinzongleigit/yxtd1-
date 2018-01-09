//
//  HuatiDongtaiViewController.m
//  yxtd
//
//  Created by qin on 2017/11/29.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "HuatiDongtaiViewController.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "HYSwitch.h"


#define padding 10
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define imageTag 2000

@interface HuatiDongtaiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic, weak)UITextView *reportStateTextView;

@property (nonatomic, weak)UIView *headView;

@property (nonatomic, weak)UILabel *pLabel;


@property (nonatomic, weak)UIButton *addPictureButton;

@property (nonatomic, copy)NSString *messageStr;
@property (nonatomic, weak) HYSwitch*switch1;


/**
 *  照片选择器
 */
@property (nonatomic,strong)AGImagePickerController *imagePicker;

@property (nonatomic,strong) UIActionSheet *actionSheet;

@property (nonatomic,strong)NSMutableArray *baseImagesArr;//存放编码之后的图片


@property (nonatomic,weak) UIImageView *pictureImageView;

/**
 *  imagePicker队列
 */
@property (nonatomic,strong)NSMutableArray *imagePickerArray;



@end

@implementation HuatiDongtaiViewController

#pragma mark - 懒加载
-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

- (NSMutableArray *)baseImagesArr
{
    if(!_baseImagesArr)
    {
        _baseImagesArr = [[NSMutableArray alloc] init];
    }
    
    return _baseImagesArr;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    
     self.tableView.scrollEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self.rightBt setBackgroundImage:[UIImage imageWithoriginName:@"fabu_Image"] forState:UIControlStateNormal];
    
    //创建表格
    UITableView*tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardDismiss:)];
    
     tap.delegate = self;

     [self.tableView addGestureRecognizer:tap];
    
    //隐藏多余的分割线
    [self setExtraCellLineHidden:self.tableView];
    
    [self initHeaderView];
    
    [self showMapLocation];

    
}

#pragma mark -显示定位
-(void)showMapLocation{
    
    __weak typeof(self.view) weakSelf=self.view;
    
    UIView*bgHView=[[UIView alloc] init];
    bgHView.backgroundColor=COLORWITHRGB(244 , 245, 245);
    [self.view addSubview:bgHView];
    [bgHView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.bottom.equalTo(weakSelf).with.offset(-13);
        
        make.height.equalTo(@27);
    }];
    
    
    UIImageView*mapImage=[[UIImageView alloc] init];
    mapImage.image=[UIImage imageWithoriginName:@"map_Image"];
    [bgHView addSubview:mapImage];
    [mapImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bgHView).with.offset(20);
        make.top.equalTo(bgHView).with.offset(6);
        
    }];
    
    UILabel*mapLabel=[[UILabel alloc] init];
    mapLabel.text=@"显示地图";
    mapLabel.textColor=BlackHexColor;
    mapLabel.font=[UIFont systemFontOfSize:12];
    [bgHView addSubview:mapLabel];
    
    [mapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(mapImage);
        make.left.equalTo(mapImage.mas_right).with.offset(10);
    }];
    
    UIView*hyView=[[UIView alloc] init];
    hyView.backgroundColor=[UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
    hyView.layer.cornerRadius=16/2;
    hyView.clipsToBounds=YES;
    [bgHView addSubview:hyView];
    [hyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(bgHView).with.offset(-9);
        make.centerY.equalTo(bgHView);
        make.size.mas_equalTo(CGSizeMake(38, 16));
        
    }];
    
    
    
    HYSwitch*switch1=[[HYSwitch alloc] init];
    self.switch1=switch1;
    switch1.offColor = [UIColor whiteColor];
    switch1.buttonColor = [UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
    [hyView addSubview:switch1];
    
    [switch1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(hyView).with.offset(1);
        make.centerY.equalTo(bgHView);
        make.size.mas_equalTo(CGSizeMake(36, 14));
    }];
    
    switch1.action = ^(BOOL isOn) {
        //关
        if (isOn==0) {
            
            self.switch1.buttonColor = [UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
            hyView.backgroundColor=[UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
            //开
        }else{
            self.switch1.buttonColor = [UIColor blackColor];
            self.switch1.onColor = [UIColor whiteColor];
            hyView.backgroundColor=[UIColor blackColor];
            
        }
    };
    
}


#define textViewHeight 120

#define pictureHW (screenWidth - 5 * padding) / 4

#define MaxImageCount 10

#define deleImageWH 25 // 删除按钮的宽高
//大图特别耗内存，不能把大图存在数组里，存类型或者小图

-(void)initHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.headView = headView;
    
    UITextView *reportStateTextView = [[UITextView alloc]initWithFrame:CGRectMake(padding / 2, padding, screenWidth - 2 * padding, textViewHeight)];
    
    reportStateTextView.text = self.reportStateTextView.text;  //防止用户已经输入了文字状态
    
    reportStateTextView.returnKeyType = UIReturnKeyDone;
    
    reportStateTextView.font = [UIFont systemFontOfSize:15];
    
    self.reportStateTextView = reportStateTextView;
    
    self.reportStateTextView.delegate = self;
    
    [[[self.reportStateTextView textInputMode] primaryLanguage] isEqualToString:@"emoji"];
    
    [self.headView addSubview:reportStateTextView];
    
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(padding, 2 * padding , screenWidth, 10)];
    
    self.pLabel = pLabel;
    
    pLabel.text = @"这一刻想说的话。。。";
    
    pLabel.hidden = [self.reportStateTextView.text length];
    
    pLabel.font = [UIFont systemFontOfSize:15];
    
    pLabel.textColor = [UIColor lightGrayColor];
    
    [self.headView addSubview:pLabel];
    
    UIView*line=[[UIView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(reportStateTextView.frame), KscreenW-padding*2, 1)];
    line.backgroundColor=btnLineColor;
    [self.headView addSubview:line];
    
    UILabel*tishiLabel=[[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(line.frame)+5, KscreenW-padding*2, 40)];
    tishiLabel.text=@"我们家射鸡师说这里一定要放照片或视屏(无辜脸)";
    tishiLabel.font=[UIFont systemFontOfSize:13];
    tishiLabel.textColor=[UIColor lightGrayColor];
    tishiLabel.textAlignment=NSTextAlignmentLeft;
    tishiLabel.numberOfLines=0;
    [self.headView addSubview:tishiLabel];
    
    NSInteger imageCount = [self.imagePickerArray count];
    
    for (NSInteger i = 0; i < imageCount; i++) {
        
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding), CGRectGetMaxY(tishiLabel.frame) + padding*2 +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        
        self.pictureImageView = pictureImageView;
        
        pictureImageView.layer.cornerRadius=10;
        pictureImageView.clipsToBounds=YES;
        
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [self.pictureImageView addGestureRecognizer:tap];
        
        //添加删除按钮
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        
        dele.frame = CGRectMake(pictureHW - deleImageWH + 3, -5, deleImageWH, deleImageWH);
        
        [dele setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.pictureImageView addSubview:dele];
        
        self.pictureImageView.tag = imageTag + i;
        
        self.pictureImageView.userInteractionEnabled = YES;
        
        self.pictureImageView.image = [UIImage imageWithCGImage:((ALAsset *)[self.imagePickerArray objectAtIndex:i]).thumbnail];
        
        [self.headView addSubview:self.pictureImageView];
    }
    if (imageCount < MaxImageCount) {
        
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), CGRectGetMaxY(tishiLabel.frame) + padding*2 +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        
        [self.headView addSubview:addPictureButton];
        
        self.addPictureButton = addPictureButton;
    }
    
    NSInteger headViewHeight = 195 + (10 + pictureHW)*([self.imagePickerArray count]/4 + 1);
    
    self.headView.frame = CGRectMake(0, 0, screenWidth, headViewHeight);
    
    self.tableView.tableHeaderView = self.headView;
    
}

#pragma mark   点击添加图片按钮
-(void)addPicture
{
    [self.tableView endEditing:YES];
    
    self.tableView.scrollEnabled = NO;
    
    [self callACtionSheetFunc];
}

#pragma mark   调用相机或相册
- (void)callACtionSheetFunc
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
        
    }else{
        
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        
    }
    
    self.actionSheet.tag = 1000;
    
    [self.actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1000)
    {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            if(buttonIndex == 0)
            {
                //来源-相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                //跳转到相机或相册界面
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
               
                imagePickerController.delegate = self;
                
                imagePickerController.allowsEditing = YES;
                
                imagePickerController.sourceType = sourceType;
                
                [self presentViewController:imagePickerController animated:YES completion:^{}];
                
            }else if (buttonIndex == 1)
            {
                [self showIpc];
            }else
            {
                return;
            }
            
        }else{
            if(buttonIndex == 2)
            {
                return;
                
            }else{
                
                [self showIpc];
            }
        }
        
        
    }
    
}

#pragma mark - imagePicker代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image=info[@"UIImagePickerControllerEditedImage"];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            ALAssetsLibrary* library = [AGImagePickerController defaultAssetsLibrary];
            
            
            void (^selectionBlock)(ALAsset*, NSUInteger, BOOL*) = ^(ALAsset* asset,
                                                                    NSUInteger index,
                                                                    BOOL* innerStop) {
                if (asset == nil) {
                    return;
                }
                
                [self.imagePickerArray addObject:asset];
                
                [self settingImage:image];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self initHeaderView];
                    
                });
            };
            
            void (^enumerationBlock)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup* group, BOOL* stop) {
                //设置过滤类型
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                
                NSUInteger index = [group numberOfAssets] - 1;
                
                NSIndexSet* lastPhotoIndexSet = [NSIndexSet indexSetWithIndex:index];
                 //枚举最后一个asset
                [group enumerateAssetsAtIndexes:lastPhotoIndexSet options:0 usingBlock:selectionBlock];
            };
            
            [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                   usingBlock:enumerationBlock
                                 failureBlock:^(NSError* error) {
                                     
                                 }];
            
        });
        
    }];
    
}

#pragma mark - 手势点击:gesture method
-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    self.navigationController.navigationBarHidden = YES;
    
    ShowImageViewController *imageVC = [[ShowImageViewController alloc] init];;
    
    imageVC.clickTag = tap.view.tag;
    
    imageVC.imageViews = self.imagePickerArray;
    
    [self.navigationController pushViewController:imageVC animated:NO];
}


#pragma mark - keyboard method
-(void)keyboardDismiss:(UITapGestureRecognizer *)tap
{
    [self.reportStateTextView resignFirstResponder];
    
     if(self.reportStateTextView.isFirstResponder){
        
        [self.reportStateTextView resignFirstResponder];
    }
}



// 删除图片
-(void)deletePic:(UIButton *)btn
{
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        
        UIImageView *imageView = (UIImageView *)(UIButton *)btn.superview;
        
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - imageTag)];
        
        [self.baseImagesArr removeObjectAtIndex:(imageView.tag - imageTag)];
        
        [imageView removeFromSuperview];
    }
    [self initHeaderView];
}

#pragma mark - 设置图片选择器
- (void)showIpc
{
    self.imagePicker = [[AGImagePickerController alloc] initWithFailureBlock:^(NSError *error) {
        
        if (error == nil)
        {
            [self dismissViewControllerAnimated:YES completion:^{}];
        } else
        {
            double delayInSeconds = 0.5;
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [self dismissViewControllerAnimated:YES completion:^{}];
                
            });
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        
    } andSuccessBlock:^(NSArray *info) {
        
        [self.imagePickerArray addObjectsFromArray:info];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            //图片（压缩尺寸、编码）
            [self settingImages:info];
        }];
        
        
        [self initHeaderView];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
    
    self.imagePicker.maximumNumberOfPhotosToBeSelected = 10 - [self.imagePickerArray count];
    
    [self presentViewController:self.imagePicker animated:YES completion:^{}];
    
}


#pragma mark    图片（压缩尺寸、编码）
- (void)settingImages:(NSArray *)selectedImagesArr
{
    for(NSInteger i =0 ; i < selectedImagesArr.count; i++)
    {
        /**
         *  获取原图
         */
        CGImageRef imageRef = ((ALAsset *)[selectedImagesArr objectAtIndex:i]).defaultRepresentation.fullScreenImage;
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        //  压缩图片
        UIImage *newImage = [self imageWithImage:image scledToSize:CGSizeMake(540, (540 / image.size.width) * image.size.height)];
        
        NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
        
        NSString *selectImg = [imageData base64EncodedStringWithOptions:0];
        
        [self.baseImagesArr addObject:selectImg];
    }
    
}

- (void)settingImage:(UIImage *)selectedImage
{
    UIImage *newImage = [self imageWithImage:selectedImage scledToSize:CGSizeMake(540, (540 / selectedImage.size.width) * selectedImage.size.height)];
    
    NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
    
    NSString *selectImg = [imageData base64EncodedStringWithOptions:0];
    
    [self.baseImagesArr addObject:selectImg];
    
}


#pragma mark   压缩图片
- (UIImage *)imageWithImage:(UIImage *)image scledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - UIGesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
    }
    return  YES;
}

#pragma mark - Text View Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.pLabel.hidden = [textView.text length];
    
    self.messageStr = textView.text;
}

#pragma mark -输入框信息变化
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 不让输入表情
    if ([textView isFirstResponder])
    {
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage])
        {
            return NO;
        }
        
        if ([@"\n" isEqualToString:text])
        {
            if ([self.reportStateTextView.text length]) {
                
                [self.reportStateTextView resignFirstResponder];
                
            }else{
                
                return NO;
            }
        }
        
    }
    
    return YES;
}




#pragma mark -表格视图的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*cellID=@"ID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.backgroundColor=[UIColor orangeColor];
    
    
    return cell;
}

#pragma mark   监听滚动视图(放弃第一响应者-隐藏键盘)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}


#pragma mark -发布按钮点击事件
-(void)rightBtnClick{
    
    [self publishMessage:self.reportStateTextView images:self.baseImagesArr];

    
}
- (void)publishMessage:(UITextView *)messageText images:(NSArray *)selectedImages
{
      [self.tableView endEditing:YES];
    if (messageText.text.length < 10 || selectedImages.count < 3) {
        
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请完善发布信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
       
       if (messageText.text.length < 10)
        {
            alertView.message = @"发布信息,不少于10个字";
            
        }else if (selectedImages.count < 3)
        {
            alertView.message = @"晒图,不少于3张";
        }
        
        [alertView show];
    }else
    {
        // 晒单——上传服务器
        [self postDataToWeb:selectedImages];
    }
   
    
}

#pragma mark   晒单——上传服务器
- (void)postDataToWeb:(NSArray *)imagesArray
{
    [MBProgressHUD showMessage:@"正在发布..." toView:self.view];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}


#pragma mark- 隐藏多余的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}


@end
