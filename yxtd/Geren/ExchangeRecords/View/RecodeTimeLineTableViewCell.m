//
//  RecodeTimeLineTableViewCell.m
//  yxtd
//
//  Created by qin on 2017/12/26.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RecodeTimeLineTableViewCell.h"

@implementation RecodeTimeLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.roundView.layer.cornerRadius=20/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
