//
//  FeedbackViewController.m
//  yxtd
//
//  Created by qin on 2018/1/8.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "FeedbackViewController.h"

#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "CustomTextField.h"

#define padding 10
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define imageTag 2000

@interface FeedbackViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UILabel*typeLabel;
@property (nonatomic,strong) UILabel*feedbackLabel;

@property (nonatomic,strong) UIButton*feedbackButton;

@property (nonatomic,strong) UIView*bgView;


@property (nonatomic, weak)UILabel *pLabel;

@property (nonatomic, weak)UITextView *feedbackTextView;

@property (nonatomic, weak)UIButton *addPictureButton;


@property (nonatomic, copy)NSString *messageStr;


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

@property (nonatomic,strong) UIView*feedbackBgView;

@property (nonatomic,strong) UIScrollView *feedScrollView;








@end

@implementation FeedbackViewController


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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title=@"意见反馈";
    
    [self.rightBt setBackgroundImage:nil forState:UIControlStateNormal];
    [self.rightBt setTitle:@"反馈记录" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    UIScrollView *feedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.feedScrollView=feedScrollView;
    feedScrollView.backgroundColor = COLORWITHRGB(244, 245, 245);
    
    feedScrollView.showsVerticalScrollIndicator = NO;
    feedScrollView.delegate=self;
    
    //设置可以滚动的范围，只能上下滚动
    feedScrollView.contentSize = CGSizeMake(0, KscreenH+150);

    [self.view addSubview:feedScrollView];
    
    
    
    //键盘出现坐标上移
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHid) name:UIKeyboardWillHideNotification object:nil];
    
    
    [self feedbackButtonView];
    
    
    [self feedbackDescription];
    
    
    [self feedbackAddUserNumber];
   
    
}


#pragma mark -键盘出现
-(void)keyBoardWillShow:(NSNotification *)aNotification{
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.feedScrollView.frame=CGRectMake(0, -height, KscreenW, KscreenH);
    
    
    
}


//键盘下移
-(void)keyBoardWillHid{
    
    self.feedScrollView.frame=CGRectMake(0, 0, KscreenW, KscreenH);
    
}

#pragma mark -联系方式
-(void)feedbackAddUserNumber{
    
    
    UILabel*lianxiLabel=[[UILabel alloc] init];
    lianxiLabel.text=@"联系方式（选填）";
    lianxiLabel.font=[UIFont systemFontOfSize:15];
    lianxiLabel.textColor=BlackHexColor;
    [self.feedScrollView addSubview:lianxiLabel];
    [lianxiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_feedbackLabel);
        make.top.mas_equalTo(self.feedbackBgView.mas_bottom).offset(10);
    }];
    
    
    
    CustomTextField*phoneNumberField=[[CustomTextField alloc] init];
    phoneNumberField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"手机号/微信/QQ" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:phoneNumberField.font}];
    phoneNumberField.textColor=BlackHexColor;
    phoneNumberField.font=[UIFont systemFontOfSize:15];
    [phoneNumberField setBackgroundColor:[UIColor whiteColor]];
    phoneNumberField.keyboardType=
    phoneNumberField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
    phoneNumberField.clearButtonMode = UITextFieldViewModeWhileEditing; // 出现删除按钮
    [self.feedScrollView addSubview:phoneNumberField];
    
    [phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(lianxiLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    
    
    
}


#define textViewHeight 120

#define pictureHW (screenWidth - 5 * padding) / 4

#define MaxImageCount 10

#define deleImageWH 25 // 删除按钮的宽高
//大图特别耗内存，不能把大图存在数组里，存类型或者小图


#pragma mark -反馈描述
-(void)feedbackDescription{
    
    UILabel*feedbackLabel=[[UILabel alloc] init];
    self.feedbackLabel=feedbackLabel;
    feedbackLabel.text=@"反馈描述";
    feedbackLabel.font=[UIFont systemFontOfSize:15];
    feedbackLabel.textColor=BlackHexColor;
    [self.feedScrollView addSubview:feedbackLabel];
    [feedbackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(10);
    }];
    
    
    [self initTextViewAndImageView];
    
    
}

#pragma mark -添加图片按钮
-(void)initTextViewAndImageView{
    
    [self.feedbackBgView removeFromSuperview]; 
    
    UIView*feedbackBgView=[[UIView alloc] init];
    self.feedbackBgView=feedbackBgView;
    feedbackBgView.backgroundColor=[UIColor whiteColor];
    [self.feedScrollView addSubview:feedbackBgView];

    UITextView *feedbackTextView = [[UITextView alloc]initWithFrame:CGRectMake(padding / 2, padding, screenWidth - 2 * padding, textViewHeight)];
    
    feedbackTextView.text = self.feedbackTextView.text;  //防止用户已经输入了文字状态
    
    feedbackTextView.returnKeyType = UIReturnKeyDone;
    
    feedbackTextView.font = [UIFont systemFontOfSize:15];
    
    self.feedbackTextView = feedbackTextView;
    
    self.feedbackTextView.delegate = self;
    
    [[[self.feedbackTextView textInputMode] primaryLanguage] isEqualToString:@"emoji"];
    
    [feedbackBgView addSubview:feedbackTextView];
    
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(padding, 2 * padding , screenWidth, 10)];
    
    self.pLabel = pLabel;
    
    pLabel.text = @"请描述在使用过程遇到的问题或者建议";
    
    pLabel.hidden = [self.feedbackTextView.text length];
    
    pLabel.font = [UIFont systemFontOfSize:15];
    
    pLabel.textColor = [UIColor lightGrayColor];
    
    [feedbackBgView addSubview:pLabel];
    
   
   
    NSInteger imageCount = [self.imagePickerArray count];
    
    for (NSInteger i = 0; i < imageCount; i++) {
        
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding), CGRectGetMaxY(feedbackTextView.frame) + padding*2 +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        
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
        
        [feedbackBgView addSubview:self.pictureImageView];
    }
    if (imageCount < MaxImageCount) {
        
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), CGRectGetMaxY(feedbackTextView.frame) + padding*2 +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        
        [feedbackBgView addSubview:addPictureButton];
        
        self.addPictureButton = addPictureButton;
    }
    
    NSInteger headViewHeight = 120 + (10 + pictureHW)*([self.imagePickerArray count]/4 + 1)+40;
    
  
    [feedbackBgView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(headViewHeight);
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.feedbackLabel.mas_bottom).offset(10);
    }];
    
   
    
}

#pragma mark   点击添加图片按钮
-(void)addPicture
{
   
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
                    
                    [self initTextViewAndImageView];
                    
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


// 删除图片
-(void)deletePic:(UIButton *)btn
{
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        
        UIImageView *imageView = (UIImageView *)(UIButton *)btn.superview;
        
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - imageTag)];
        
        [self.baseImagesArr removeObjectAtIndex:(imageView.tag - imageTag)];
        
        [imageView removeFromSuperview];
    }
    
    [self initTextViewAndImageView];
    
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
        
        
        [self initTextViewAndImageView];
        
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
            if ([self.feedbackTextView.text length]) {
                
                [self.feedbackTextView resignFirstResponder];
                
            }else{
                
                return NO;
            }
        }
        
    }
    
    return YES;
}



#pragma mark -分类标签标题
-(void)feedbackButtonView{
    
    UILabel*typeLabel=[[UILabel alloc] init];
    self.typeLabel=typeLabel;
    typeLabel.text=@"分类标签标题";
    typeLabel.font=[UIFont systemFontOfSize:15];
    typeLabel.textColor=BlackHexColor;
    [self.feedScrollView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    
    
    UIView*bgView=[[UIView alloc] init];
    bgView.backgroundColor=[UIColor whiteColor];
    self.bgView=bgView;
    [self.feedScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(typeLabel.mas_bottom).offset(10);
    }];
    
    NSMutableArray*cellArray=[NSMutableArray new];
    
    NSArray*buttonArr=@[@"功能建议",@"bug提交",@"商家问题"];
    
    for (int i=0; i<buttonArr.count; i++) {
        
        UIButton*feedbackButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.feedbackButton=feedbackButton;
        feedbackButton.backgroundColor=[UIColor whiteColor];
        [feedbackButton setTitle:buttonArr[i] forState:UIControlStateNormal];
        feedbackButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [feedbackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       [feedbackButton setTitleColor:COLORWITHRGB(0, 219, 220) forState:UIControlStateSelected];
        
        feedbackButton.layer.borderWidth=1;
        feedbackButton.layer.borderColor=[UIColor blackColor].CGColor;
       
        feedbackButton.layer.cornerRadius=5;
        feedbackButton.clipsToBounds=YES;
        feedbackButton.tag=1000+i;
        [bgView addSubview:feedbackButton];
        
        [feedbackButton addTarget:self action:@selector(feedbackAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cellArray addObject:feedbackButton];
    }
    //水平方向控件间隔固定等间隔
    [cellArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:SYRealValueWidth(30) leadSpacing:SYRealValueWidth(46) tailSpacing:SYRealValueWidth(46)];
    
    [cellArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.height.equalTo(@38);
    }];
    
    
}

#pragma mark -分类标签按钮点击事件
-(void)feedbackAction:(UIButton*)btn{
    
   
    for(int i=1000 ;i<1003;i++)
    {
        UIButton *selectButton =(UIButton  *)[ self.view viewWithTag:i];
        selectButton.selected = NO;
        selectButton.layer.borderColor=[UIColor blackColor].CGColor;
    }
    
    btn.layer.borderColor=COLORWITHRGB(0, 219, 220).CGColor;
  
     btn.selected = YES;
    
    
}


-(void)leftBtnClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)rightBtnClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"反馈记录提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}


#pragma  mark   滚动视图的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
 
    //隐藏键盘
    [scrollView endEditing:YES];
    

}




@end
