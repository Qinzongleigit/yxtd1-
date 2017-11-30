//
//  ShowImageView.h
//  yxtd
//
//  Created by 覃宗雷 on 2017/11/30.
//  Copyright © 2017年 qin. All rights reserved.
//

//用来处理图片点击后放大的效果
#import <UIKit/UIKit.h>
//typedef，为现有类型创建一个新的名字
//typedef  返回类型(*新类型)(参数表)
typedef void(^didRemoveImage)();

@interface ShowImageView : UIView

@property (nonatomic,copy) didRemoveImage removeImg;

-(id)initWithFrame:(CGRect)frame byClickTag:(NSInteger)clickTag appendArray:(NSArray *)appendArray;




@end
