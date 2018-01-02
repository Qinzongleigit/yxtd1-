//
//  FootView.h
//  tableViewtest
//
//  Created by 覃宗雷 on 2017/12/28.
//  Copyright © 2017年 leizongqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootView : UIView

@property (nonatomic,strong) void(^allBtnBolock)(UIButton *myBt);

@property (nonatomic,strong) void(^deleteBtnBolock)(void);

@property (nonatomic,strong) UIButton*allBtn;

@property (nonatomic,strong) UIButton*deleteBtn;
@end
