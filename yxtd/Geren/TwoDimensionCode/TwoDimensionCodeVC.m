//
//  TwoDimensionCodeVC.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/11/28.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "TwoDimensionCodeVC.h"

@interface TwoDimensionCodeVC ()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic , strong) NSMutableString *twoCodeUrls;

@end

@implementation TwoDimensionCodeVC


//跳转链接地址
- (NSMutableString *)twoCodeUrls
{
    if(!_twoCodeUrls)
    {
        _twoCodeUrls = [[NSMutableString alloc] init];
    }
    return _twoCodeUrls;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //头像
    UIImageView*iconImage=[[UIImageView alloc] init];
    iconImage.backgroundColor=[UIColor purpleColor];
    iconImage.layer.cornerRadius=74/2;
    iconImage.clipsToBounds=YES;
    [self.view addSubview:iconImage];
    
    //昵称
    UILabel*nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"骑猪去放🐂";
    nameLabel.textColor=BlackHexColor;
    nameLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    
    //二维码显示
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView=imageView;
    [self.view addSubview:imageView];
   
    //返回按钮
    UIButton*takeBackBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [takeBackBt setBackgroundImage:[UIImage imageWithoriginName:@"takeBack_Image"] forState:UIControlStateNormal];
    [takeBackBt addTarget:self action:@selector(takeBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takeBackBt];
    
    
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(74, 74));
        make.top.equalTo(self.view).offset(SYRealValueHeight(126));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconImage);
        make.top.equalTo(iconImage.mas_bottom).offset(26);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameLabel.mas_bottom).offset(30);
   make.size.mas_equalTo(self.view.mas_width).multipliedBy(0.6);
    }];
    
    
    [takeBackBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
       make.bottom.equalTo(self.view.mas_bottom).offset(-SYRealValueHeight(74));
    }];
    
    
    [self twoCodeUrls];
    
    [self requestData];
    
}

#pragma mark -获取二维码接口Url
- (void)requestData
{
//    CDHttpParam *params = [[CDHttpParam alloc] init];
//
//    [CDHttpTool GET:kTwoCode parameters:params.mj_keyValues success:^(id responseObject)
//     {
//
    
//
//         if([responseObject[@"status"] integerValue] == 1)
//         {
//
             _twoCodeUrls = @"https://www.baidu.com";
             
            // NSDictionary *data = responseObject[@"data"];
             
           //  _twoCodeUrls = data[@"download"];
             
        // }
         [self makeTwoCode:_twoCodeUrls];
         
    // } failure:^(NSError *error)
    // {
         
       //  [self makeTwoCode:_twoCodeUrls];
         
    // }];
}


- (void)makeTwoCode:(NSString *)urls
{
    NSString *message = urls;
    
    CGFloat codeSize = 1000;
    
    CGFloat imageSize = 6;
    
    //中间二维码图像
    UIImage *iconImage = [UIImage imageNamed:@"iconImage"];
    
    NSDictionary *rgb = @{@"red":@(0),@"green":@(0),@"blue":@(0)};
    


    [self showTwoDimensionCodeMessage:message codeSize:codeSize iconSize:imageSize iconImage:iconImage RGB:rgb];
    
}


#pragma mark   显示二维码

- (void)showTwoDimensionCodeMessage:(NSString *)message codeSize:(CGFloat)codeSize iconSize:(CGFloat)iconSize iconImage:(UIImage *)iconImage RGB:(NSDictionary *)color
{
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:message] withSize:codeSize];
    
    UIImage *newImage = [self imageBlackToTransparent:image withRed:[color[@"red"] doubleValue] andGreen:[color[@"green"] doubleValue] andBlue:[color[@"blue"] doubleValue]];
    
    //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
    UIImage *imgIcon = [self createRoundedRectImage:iconImage withSize: CGSizeMake(70.0, 93.0) withRadius:10];
    
    UIImage *lastImage = [self addIconToQRCodeImage:newImage withIcon:imgIcon withScale:iconSize];

    self.imageView.image=lastImage;
    
}


#pragma mark   设置图片圆角
- (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius {
    
    int w = size.width;
    
    int h = size.height;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(contextRef);
    
    addRoundedRectToPath(contextRef, rect, radius, radius);
    
    CGContextClosePath(contextRef);
    
    CGContextClip(contextRef);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    
    CGColorSpaceRelease(colorSpaceRef);
    
    CGImageRelease(imageMasked);
    
    return img;
}

static void addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius) {
    
    float fw, fh;
    
    if (widthOfRadius == 0 || heightOfRadius == 0)
    {
        CGContextAddRect(contextRef, rect);
        
        return;
    }
    
    CGContextSaveGState(contextRef);
    
    CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
    
    CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
    
    fw = CGRectGetWidth(rect) / widthOfRadius;
    
    fh = CGRectGetHeight(rect) / heightOfRadius;
    
    CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
    
    CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
    
    CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
    
    CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
    
    CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(contextRef);
    
    CGContextRestoreGState(contextRef);
}


#pragma mark   生成二维码，传入字符串即可
- (CIImage *)createQRForString:(NSString *)qrString
{
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    //设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    [qrFilter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    
    // 返回CIImage
    return qrFilter.outputImage;
}


#pragma mark   设置UIImage的大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}


#pragma mark   修改二维码的颜色
void ProviderReleaseData (void *info, const void *data, size_t size){
    
    free((void*)data);
}

- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue
{
    
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t      bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    
    return resultUIImage;
}


- (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale
{
    UIGraphicsBeginImageContext(image.size);
    
    //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = widthOfImage/scale;
    CGFloat heightOfIcon = heightOfImage/scale;
    
    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,widthOfIcon, heightOfIcon)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}



-(void)takeBackClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




@end
