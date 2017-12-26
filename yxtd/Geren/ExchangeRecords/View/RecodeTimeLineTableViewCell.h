//
//  RecodeTimeLineTableViewCell.h
//  yxtd
//
//  Created by qin on 2017/12/26.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecodeTimeLineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *recodeLabel;

@end
