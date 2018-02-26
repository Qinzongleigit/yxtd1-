//
//  DetailFansAndFocusCellFrame.h
//  yxtd
//
//  Created by qin on 2018/2/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailArrayModel.h"
#import "DetailFansAndFocusModel.h"

@interface DetailFansAndFocusCellFrame : NSObject
//F为Frame
@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect shuoshuotextF;
@property (nonatomic,strong) NSMutableArray *picturesF;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGRect timeF;

@property (nonatomic,assign) CGRect replyF;
@property (nonatomic,strong) NSMutableArray *replysF;
@property (nonatomic,assign) CGRect replyBackgroundF;
@property (nonatomic,strong) DetailArrayModel *modelGroup;
//@property (nonatomic,strong) DetailFansAndFocusModel*model;

@end
