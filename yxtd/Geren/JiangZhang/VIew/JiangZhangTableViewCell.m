//
//  JiangZhangTableViewCell.m
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiangZhangTableViewCell.h"

@implementation JiangZhangTableViewCell



-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    int i=3;
    self.cellView.indexPath = self.indexPath;
    self.cellView.dataArray = _dataArray;
    
    self.numberLabel.text=[NSString stringWithFormat:@"( 已获得 %d 枚 )",i];
    self.numberLabel.alpha=0.5;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
