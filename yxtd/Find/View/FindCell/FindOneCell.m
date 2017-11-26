//
//  FindOneCell.m
//  yxtd
//
//  Created by qin on 2017/9/28.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FindOneCell.h"
#import "CDMyButton.h"

@interface FindOneCell ()

@property (nonatomic,strong) UIView*btView;


@end

@implementation FindOneCell


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"FindOneCell";
    
    FindOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        
         [self setUpBtn];
    }
    return self;
}

-(void)setUpBtn{
    
    UIView*btView=[[UIView alloc] init];
    self.btView=btView;
    btView.backgroundColor=[UIColor whiteColor];
    
    
    NSMutableArray *imageArrM = [NSMutableArray array];

    [imageArrM addObject:[UIImage imageNamed:@"dongtai_Image"]];
    
    [imageArrM addObject:[UIImage imageNamed:@"exchange_Image"]];
    
    [imageArrM addObject:[UIImage imageNamed:@"topic_Image"]];
    
    NSMutableArray *titleArrM = [NSMutableArray arrayWithObjects:@"动态", @"互换", @"话题", nil];
    
    for (int i = 0; i < titleArrM.count; i ++)
    {
         CDMyButton*btn = [CDMyButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        [btn addTarget:self action:@selector(duobaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setUpBtnImage:imageArrM[i] Title:titleArrM[i]];
        
        [btView addSubview:btn];
    }
    [self addSubview:btView];
    

}

//按钮点击事件传值
-(void)duobaoBtnClick:(UIButton*)bt{
    
    self.btTagBlock(bt.tag);
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.btView.frame=CGRectMake(0, 0, KscreenW, 76);
    
    int count = 0;
    
    CGFloat margin = 10;
    
    //CGFloat btnViewHeight = 66;
    
    for (CDMyButton *btn in self.btView.subviews)
    {
        
        CGFloat btnWidth = (self.width - 3 * margin) / self.btView.subviews.count;

        CGFloat btnHeigth = 55;
        
        btn.imageWidth = 22;
        
        CGFloat btnX = (btnWidth + margin) * count + margin;
        
        CGFloat btnY = 10;
        
        btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeigth);
        
        count++;
    }
    

}




@end
