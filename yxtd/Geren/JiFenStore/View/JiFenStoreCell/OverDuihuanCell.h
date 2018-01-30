//
//  OverDuihuanCell.h
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiFenCanDuiHuanModel.h"

@interface OverDuihuanCell : UICollectionViewCell

- (void)fillCellWithModel:(JiFenCanDuiHuanModel *)model indexPath:(NSIndexPath *)path;

@end
