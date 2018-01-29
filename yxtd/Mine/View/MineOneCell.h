//
//  MineOneCell.h
//  yxtd
//
//  Created by qin on 2017/10/12.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineOneCell : UITableViewCell

@property (nonatomic,strong) void(^codeBtBlock)(void);

@property (nonatomic,strong) void(^tapBlock)(NSInteger tapTag);

@property (nonatomic,strong) UIImageView*iconImage;

@property (nonatomic,strong) UILabel*nameLabel;

@property (nonatomic,strong) UIButton*codeImageBt;

@property (nonatomic,strong) UILabel*guanzhuLabel;

@property (nonatomic,strong) UILabel*fensiLabel;

@property (nonatomic,strong) UILabel*dongtaiLabel;

@property (nonatomic,strong) UILabel*guanzhuNumber;

@property (nonatomic,strong) UILabel*fensiNumber;

@property (nonatomic,strong) UILabel*dongtaiNumber;

@property (nonatomic, strong) UIView *cutLineView;

@property (nonatomic,strong) NSString*iconImageStr;


@end
