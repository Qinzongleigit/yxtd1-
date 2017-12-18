//
//  MyDiscountTopSliderView.h
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myDiscountBtnClickBlock)(NSInteger index);

@interface MyDiscountTopSliderView : UIView

@property (nonatomic,copy) myDiscountBtnClickBlock myDiscountIndexBlock;
@property (nonatomic,weak) UIView*coverView;
@property (nonatomic,strong) UIButton*slicdeButton;


@end
