//
//  ShowBigImageView.h
//  yxtd
//
//  Created by qin on 2018/2/26.
//  Copyright © 2018年 qin. All rights reserved.
//

//用来处理图片点击后放大的效果
#import <UIKit/UIKit.h>

typedef void(^didRemoveImage)(void);

@interface ShowBigImageView : UIView

@property (nonatomic,copy)didRemoveImage removeImg;
-(id)initWithFrame:(CGRect)frame byClickTag:(NSInteger)clickTag appendArray:(NSArray *)appendArray;

@end
