//
//  CDFindHeaderView.m
//  yxtd
//
//  Created by qin on 2017/9/22.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "CDFindHeaderView.h"
#import "CDFindImgScrollView.h"

@interface CDFindHeaderView ()<UIScrollViewDelegate>


@property (nonatomic, weak) CDFindImgScrollView *findImgScrollView;

@property (nonatomic,weak) UIPageControl *pageControl;



@end

@implementation CDFindHeaderView

-(instancetype)initWithFrame:(CGRect)frame NSArray:(NSArray *)array{
    
    if ([super initWithFrame:frame]) {
        
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.width;
    CGFloat height =self.height;
    
    [self.findImgScrollView removeFromSuperview];
    
    CDFindImgScrollView *findImgScrollView = [[CDFindImgScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    
    // ---------- 设置代理 --------
    findImgScrollView.delegate = self;
    
    self.findImgScrollView = findImgScrollView;
     
    self.findImgScrollView.goodsImgArr = array;
    
    
    [self addSubview:findImgScrollView];
    
    [self setUpPageControl];
        

    }
    return self;
    
}

#pragma mark - 设置pageControl;
- (void)setUpPageControl
{
    [self.pageControl removeFromSuperview];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    self.pageControl = pageControl;
    
    pageControl.numberOfPages = self.findImgScrollView.goodsImgArr.count;
    
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self addSubview:pageControl];
    
    CGFloat pageControlWidth = 100;
    CGFloat pageControlHegiht = 20;
    CGFloat pageControlX = self.findImgScrollView.center.x - pageControlWidth / 2;
    CGFloat pageControlY = self.findImgScrollView.height - pageControlHegiht;
    
    pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlWidth, pageControlHegiht);
}

#pragma mark - UIScrollViewDelegate 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.findImgScrollView.contentOffset.x  / self.findImgScrollView.width;
}

#pragma mark  滚动视图代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentPage=scrollView.contentOffset.x/KscreenW;
    
    //拖动时回调的方法
    [_delegete DataBack:currentPage];
    
   
}

//滚动动画结束(自动滚动与分页控件联动)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 当前页
   int currentPage = scrollView.contentOffset.x / KscreenW;
    
    //自动滚动时回调的方法
    [_delegete DataBack:currentPage];
    
   
}





@end
