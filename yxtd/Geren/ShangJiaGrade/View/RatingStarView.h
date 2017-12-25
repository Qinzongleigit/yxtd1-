//
//  RatingStarView.h
//  yxtd
//
//  Created by qin on 2017/12/25.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingStarView;

typedef void(^ChangeRatingStarHandle) (NSInteger starNum);

@interface RatingStarView : UIView

/**
 初始化评分Bar
 
 @param frame frame
 @param unselImg 正常的星星图片名称
 @param selImg 选中时的星星图片名称
 @param enable 是否可以改变评分
 @return bar
 */
- (instancetype)initWithRatingBarFrame:(CGRect)frame
                              unselImg:(NSString *)unselImg
                                selImg:(NSString *)selImg
                         ratingStarNum:(NSInteger)starCount
                               isEable:(BOOL)enable;


@property (nonatomic,copy) ChangeRatingStarHandle starNumBlock;


@end
