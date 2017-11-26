//
//  HYSwitch.m
//  yxtd
//
//  Created by qin on 2017/10/26.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "HYSwitch.h"
#define DEFAULT_ON_COLOR [UIColor colorWithRed:76/255.f green:216/255.f blue:100/255.f alpha:1]

@interface HYSwitch ()

@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, getter = isOn) BOOL on;

@end

@implementation HYSwitch

#pragma mark - 初始化相关
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setDefaultValue];
        
        self.backgroundColor = self.offColor;

        self.circleView=[[UIView alloc] init];
        self.circleView.layer.cornerRadius=11/2;
        self.circleView.layer.masksToBounds = YES;
        self.circleView.backgroundColor = self.buttonColor;
        [self addSubview:self.circleView];
        [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).with.offset(1);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];

        self.layer.cornerRadius = 14/2;
        self.layer.masksToBounds = YES;
        
        [self setupGestures];
    }
    return self;
}

#pragma mark-初始化
- (void)setDefaultValue
{
    self.onColor = DEFAULT_ON_COLOR;
    self.offColor = [UIColor lightGrayColor];
    self.buttonColor = [UIColor whiteColor];
}

#pragma mark-添加手势
- (void)setupGestures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler:)];
    [self addGestureRecognizer:tap];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandler:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - setter方法

- (void)setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    self.circleView.backgroundColor = buttonColor;
}

- (void)setOnColor:(UIColor *)onColor
{
    _onColor = onColor;
    if (self.isOn) {
        self.backgroundColor = onColor;
    }
}

- (void)setOffColor:(UIColor *)offColor
{
    _offColor = offColor;
    if (!self.isOn) {
        self.backgroundColor = offColor;
    }
}

#pragma mark - 设置开关方法

- (void)setSwitchOn:(BOOL)on animated:(BOOL)animated
{
    self.on = on;
    if (on) {
        [self onAnimationWithAnimated:animated];
    } else {
        [self offAnimationWithAnimated:animated];
    }
}

#pragma mark - 手势处理

static BOOL oldOn = NO;
- (void)panHandler:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        //手势开始的时候记录开关的当前状态.
        oldOn = self.isOn;
    }

    if (pan.state != UIGestureRecognizerStateEnded) {
        CGPoint point = [pan translationInView:self];
        if (point.x > 0) {
            [self setSwitchOn:YES animated:YES];
        } else if (point.x < 0) {
            [self setSwitchOn:NO animated:YES];
        }
    } else {
        //如果pan手势结束后的开关状态与开始记录的旧状态不同, 则执行action.
        if (oldOn != self.isOn) {
            [self performAction];
        }
    }

    [pan setTranslation:CGPointZero inView:self];
}

- (void)tapHandler:(UITapGestureRecognizer *)tap
{
    [self setSwitchOn:!self.isOn animated:YES];
    [self performAction];
}

#pragma mark - 其他

- (void)performAction
{
    if (self.action) {
        self.action(self.isOn);
    }
}

#pragma mark-打开开关动画
- (void)onAnimationWithAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            self.backgroundColor = self.onColor;
            self.circleView.center = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetHeight(self.frame)/2,
                                                 CGRectGetHeight(self.frame)/2);

        } completion:^(BOOL finished) {

        }];
    } else {
        self.backgroundColor = self.onColor;
        self.circleView.center = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetHeight(self.frame)/2,
                                             CGRectGetHeight(self.frame)/2);

    }

}

#pragma mark-关闭开关动画
- (void)offAnimationWithAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            self.backgroundColor = self.offColor;
            self.circleView.center = CGPointMake(CGRectGetHeight(self.frame)/2,
                                                 CGRectGetHeight(self.frame)/2);

        } completion:^(BOOL finished) {

        }];
    } else {
        self.backgroundColor = self.offColor;
        self.circleView.center = CGPointMake(CGRectGetHeight(self.frame)/2,
                                             CGRectGetHeight(self.frame)/2);

    }
}


@end
