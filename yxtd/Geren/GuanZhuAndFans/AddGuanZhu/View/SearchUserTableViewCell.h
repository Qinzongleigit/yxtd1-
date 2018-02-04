//
//  SearchUserTableViewCell.h
//  yxtd
//
//  Created by qin on 2018/2/4.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface SearchUserTableViewCell : UITableViewCell

- (void)fillCellWithModel:(DataModel*)model indexPath:(NSIndexPath *)path;

@end
