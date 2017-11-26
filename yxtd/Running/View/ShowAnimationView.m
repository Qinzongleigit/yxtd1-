//
//  ShowAnimationView.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/11/12.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ShowAnimationView.h"

@interface ShowAnimationView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView  *contentView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView*scrollView;
@property (nonatomic,assign) NSInteger indexPage;


@end

@implementation ShowAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutAllSubviews];
        
    }
    return self;
}

- (void)layoutAllSubviews{
    
    /*创建灰色背景*/
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.alpha = 0.6;
    bgView.backgroundColor = [UIColor grayColor];
    [self addSubview:bgView];
    
    
    /*创建显示View*/
    _scrollView=[[UIScrollView alloc] init];
    _scrollView.frame=self.bounds;
    _scrollView.contentSize=CGSizeMake(KscreenW*3, KscreenH);
   
  for (int i=0; i<3; i++) {
        
      UIImageView*_imageView= [[UIImageView alloc] init];

      _imageView.frame=CGRectMake(50, KscreenH, KscreenW-100, 200);
      NSString *imageName = [NSString stringWithFormat:@"Welcome%d.jpg",1];
      
      _imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:_imageView];
      
      _imageView.tag=1001;
      
      [UIView animateWithDuration:0.5 animations:^{
          
            _imageView.frame = CGRectMake(50, KscreenH/2-100, KscreenW-100, 200);
      } completion:^(BOOL finished) {
          
          _imageView.frame = CGRectMake(50+KscreenW*i, KscreenH/2-100, KscreenW-100, 250);
          
          NSString *imageName = [NSString stringWithFormat:@"Welcome%d.jpg",i+1];
          
          _imageView.image = [UIImage imageNamed:imageName];
      }];
        
      _imageView.layer.cornerRadius=10;
      _imageView.clipsToBounds=YES;
      
  }

    // 分页使能
    _scrollView.pagingEnabled = YES;
    // 滚动条
      // 水平
    _scrollView.showsHorizontalScrollIndicator = NO;
    //    垂直
    _scrollView.showsVerticalScrollIndicator = NO;
    // 弹簧效果
    _scrollView.bounces = NO;

    // 设置成为代理
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    [self bringSubviewToFront:_scrollView];
    
    
    
    
    
    // 分页控件的添加
    _pageControl= [[UIPageControl alloc] init];
    _pageControl.backgroundColor = [UIColor clearColor];
    // 总个数
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
    _pageControl.pageIndicatorTintColor=[UIColor grayColor];
    
    [self  addSubview:_pageControl];
    //取出对象
     UIImageView*imageView=(UIImageView*)[self viewWithTag:1001];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(imageView);
        make.bottom.equalTo(imageView.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
    }];
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closeImage"] forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_pageControl);
        make.top.equalTo(_pageControl.mas_bottom).with.offset(20);
    }];

    
   
    
}

// 结束滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 
    // 确定具体是哪张，具体位置(由偏移位置可以判断出当前是在哪一页，除以屏幕宽度就可以得到页数了)
  _indexPage = scrollView.contentOffset.x / KscreenW;
    
    // 改变页码
    _pageControl.currentPage = self.indexPage;
    
    
}

#pragma mark - 按钮点击事件,移除View
- (void)closeBtClick{
    
    [self dismissContactView];
}

-(void)dismissContactView
{
    __weak typeof(self)weakSelf = self;
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}


// 这里加载在了window上就是全屏
-(void)showView
{
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
    
}  


@end
