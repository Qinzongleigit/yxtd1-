//
//  FindOneCell.h
//  yxtd
//
//  Created by qin on 2017/9/28.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btClickBlock)(NSInteger tag);

@interface FindOneCell : UICollectionViewCell
@property (nonatomic,copy) btClickBlock btTagBlock;


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;

@end
