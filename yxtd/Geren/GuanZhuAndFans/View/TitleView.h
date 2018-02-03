//
//  TitleView.h
//  UInabarView
//
//  Created by qin on 2018/1/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIView

@property (nonatomic,strong) void(^titleBtBlock)(NSInteger tag);


@property (nonatomic,strong) NSArray*titleArr;

@property (nonatomic,assign) NSInteger numTag;

@end
