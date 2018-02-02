//
//  GuanZhuTableViewCell.h
//  yxtd
//
//  Created by qin on 2018/2/2.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuanZhuModel.h"

@interface GuanZhuTableViewCell : UITableViewCell

- (void)fillCellWithModel:(GuanZhuModel*)model indexPath:(NSIndexPath *)path;



@end
