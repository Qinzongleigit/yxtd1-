//
//  CDFindImgScrollView.m
//  yxtd
//
//  Created by qin on 2017/9/22.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "CDFindImgScrollView.h"
#import <UIImageView+WebCache.h>

@implementation CDFindImgScrollView

- (void)setGoodsImgArr:(NSArray *)goodsImgArr
{
    _goodsImgArr = goodsImgArr;
    
    [self setUpScrollViewContent];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setUpScrollViewContent];
    }
    return self;
}

- (void)setUpScrollViewContent
{
    self.contentSize = CGSizeMake(KscreenW * self.goodsImgArr.count, self.height);
    
    int count = 0;
    
    
    for (NSString *imgUrlStr in self.goodsImgArr)
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        //裁剪图片,超出控件的部分裁掉
        imgView.clipsToBounds = YES;
        
        if (imgUrlStr.length != 0) {
            
            NSURL *imgUrl = [NSURL URLWithString:imgUrlStr];
            
#pragma mark - 根据网址设置图片
          [imgView sd_setImageWithURL:imgUrl placeholderImage:nil];
           
            
        }
        
        CGFloat x = self.width * count;
        
        CGFloat y = 0;
        
        CGFloat width = self.width;
        
        CGFloat height = self.height;
        
        imgView.frame = CGRectMake(x, y, width, height);
        
        [self addSubview:imgView];
        
        count ++;
    }
    
    self.bounces = NO;
    
    self.pagingEnabled = YES;
    
    self.showsHorizontalScrollIndicator = NO;
    
    self.showsVerticalScrollIndicator = NO;
}



@end
