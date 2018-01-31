//
//  SaishiGoodsCell.h
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiFenSaiShiModel.h"

@interface SaishiGoodsCell : UICollectionViewCell

- (void)fillCellWithModel:(JiFenSaiShiModel *)model indexPath:(NSIndexPath *)path;

@end
