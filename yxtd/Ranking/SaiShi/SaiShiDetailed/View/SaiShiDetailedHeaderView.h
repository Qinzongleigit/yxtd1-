//
//  SaiShiDetailedHeaderView.h
//  yxtd
//
//  Created by qin on 2017/9/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^myBtnClickBlock)(NSInteger index);

@interface SaiShiDetailedHeaderView : UIView


@property (nonatomic,copy) myBtnClickBlock myIndexBlock;


@end





