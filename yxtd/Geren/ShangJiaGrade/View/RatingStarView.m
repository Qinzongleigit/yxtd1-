//
//  RatingStarView.m
//  yxtd
//
//  Created by qin on 2017/12/25.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RatingStarView.h"

#define SCALE 1

const NSUInteger DEFAULT_STAR_COUNT = 5;


@interface RatingStarView ()

/**
 底层未选中时的View
 */
@property(nonatomic, strong) UIView * bottomView;
/**
 上层选中时的View
 */
@property(nonatomic, strong) UIView * topView;
/**
 星星的宽度
 */
@property(nonatomic, assign) CGFloat starWidth;
/**
 是否可以改变星星的评分
 */
@property(nonatomic, assign,getter=isEnable) BOOL enable;

/**
 没有选择时的图片
 */
@property(nonatomic, copy) NSString * unselImgName;
/**
 选择时的图片
 */
@property(nonatomic, copy) NSString * selImgName;

/**
 选中星星的个数
 */
@property(nonatomic, assign) NSInteger starCount;

/**
 改变之后的星星个数
 */
@property(nonatomic, assign) NSInteger finalStarNum;


@end


@implementation RatingStarView

- (instancetype)initWithRatingBarFrame:(CGRect)frame unselImg:(NSString *)unselImg selImg:(NSString *)selImg ratingStarNum:(NSInteger)starCount isEable:(BOOL)enable
{
    if (self = [super initWithFrame:frame]) {
        self.enable = enable;
        self.starCount = starCount;
        self.unselImgName = unselImg;
        self.selImgName = selImg;
        //添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        
        [self initWithStarCount:DEFAULT_STAR_COUNT];
        
    }
    return self;
}



- (void)initWithStarCount:(NSUInteger)count
{
    
    self.bottomView = [[UIView alloc] initWithFrame:self.bounds];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.bottomView];
    [self addSubview:self.topView];
    
    self.topView.clipsToBounds = YES;
    self.topView.userInteractionEnabled = NO;
    self.bottomView.userInteractionEnabled = NO;
    self.userInteractionEnabled = YES;
    
    CGFloat starWidth = 30;
    self.starWidth = starWidth;
    
    for (int i = 0; i < count; i ++) {
        
        UIImageView * unselImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, starWidth * SCALE, starWidth * SCALE)];
        unselImg.center = CGPointMake((i + 0.5)*self.starWidth+10*(i+1), self.frame.size.height / 2);
        unselImg.image = [UIImage imageNamed:self.unselImgName];
        [self.bottomView addSubview:unselImg];
        
        
        UIImageView * selImg = [[UIImageView alloc] initWithFrame:unselImg.frame];
        selImg.center = unselImg.center;
        selImg.image = [UIImage imageNamed:self.selImgName];
        [self.topView addSubview:selImg];
        
    }
    
    
    if (self.starCount > 0) {//开始的时候就已经有选中的星星了
        self.topView.frame = CGRectMake(0, 0, self.starWidth * self.starCount+10, self.bounds.size.height);
        
        
    }
    
}


#pragma mark -- 手势
- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (self.isEnable) {
        
        CGPoint point = [gesture locationInView:self];
        
        
        NSInteger count = (int)(point.x / self.starWidth) ;
        
        if (count==0) {
            count=1;
            self.topView.frame = CGRectMake(0, 0, self.starWidth * count+10*count, self.bounds.size.height);
        }{
            
            self.topView.frame = CGRectMake(0, 0, self.starWidth * count+10*count, self.bounds.size.height);
        }
        
        if (count > 5) {
            _finalStarNum = DEFAULT_STAR_COUNT;
        }else{
            _finalStarNum = count;
        }
        
        if (self.starNumBlock != nil) {
            self.starNumBlock(_finalStarNum);
        }
        
        
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if(self.isEnable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x / self.starWidth);
        
        
        
        if (count > 0 && count <= DEFAULT_STAR_COUNT && _finalStarNum != count) {
            
            self.topView.frame = CGRectMake(0, 0, self.starWidth * count +10*count, self.bounds.size.height);
            
            _finalStarNum = count ;
            
            
        }
        
        if (count == 0) {
            count = 1;
            self.topView.frame = CGRectMake(0, 0, self.starWidth * 1+10, self.bounds.size.height);
            _finalStarNum = count;
        }
        
        
        if (self.starNumBlock != nil) {
            self.starNumBlock(_finalStarNum);
        }
        
        
    }
    
}


@end
