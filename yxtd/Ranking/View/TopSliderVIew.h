//
//  TopSliderVIew.h
//  SliderView
//
//  Created by qin on 2017/9/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBtnClickBlock)(NSInteger index);

@interface TopSliderVIew : UIView

@property (nonatomic,copy) myBtnClickBlock myIndexBlock;
@property (nonatomic,weak) UIView*coverView;

@end
