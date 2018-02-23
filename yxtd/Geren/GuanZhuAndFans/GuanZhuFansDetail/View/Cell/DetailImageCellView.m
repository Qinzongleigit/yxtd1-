//
//  DetailImageCellView.m
//  yxtd
//
//  Created by qin on 2018/2/8.
//  Copyright © 2018年 qin. All rights reserved.
//

#define ImageJianXi 20.0f

#import "DetailImageCellView.h"
#import "UIButton+WebCache.h"

@interface DetailImageCellView ()

//个数
@property (nonatomic,assign) NSInteger columns;

//高度
@property (nonatomic,assign) NSInteger height;

@end

@implementation DetailImageCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        [self loadSetUpViewLayout];
        
    }
    return self;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self loadSetUpViewLayout];
}

//布局动态图片界面
-(void)loadSetUpViewLayout{
    
    self.backgroundColor=[UIColor whiteColor];
    
    //一行有多少个图片显示
        self.columns=3;
    

    //每张图片的宽度
    self.height=(KscreenW-(self.columns+1)*ImageJianXi)/self.columns;
    
}

-(void)setDataArrayCount:(NSInteger)dataArrayCount{
    
    _dataArrayCount=dataArrayCount;
      self.cellHeight=[self heightForCount:_dataArrayCount];
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath=indexPath;
}

-(void)setDataImageArray:(NSArray *)dataImageArray{
    
    _dataImageArray=dataImageArray;
    
    for (UIView*view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self loadCreateScratchableLatex];
}
//创建九宫格---
- (void)loadCreateScratchableLatex {
    
    if (self.dataImageArray.count<=0) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.text = @"暂无图片显示";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        
    }else{
        for (NSInteger i = 0; i < self.dataImageArray.count ; i++) {
       
            UIImageView*imageView=[[UIImageView alloc] initWithFrame:[self frameForItemIndex:i]];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.dataImageArray[i]]]];
            
            imageView.userInteractionEnabled=YES;
            imageView.tag=i+1000;
             [self addSubview:imageView];
            UITapGestureRecognizer*imageTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTapAction:)];
            [imageView addGestureRecognizer:imageTap];
            
        }
        
    }
    
}

//btn的点击响应事件
- (void)clickTapAction:(UITapGestureRecognizer *)tap {
    
    //获取图片tag
    UIView *views = (UIView*) tap.view;
    NSUInteger tag = views.tag;
    
    self.ReturnImageClickItemIndex(self.indexPath, tag - 1000);
}

//计算每个UIButton的frame
-(CGRect)frameForItemIndex:(NSInteger)count{
    
    //每个图片的宽度
    CGFloat itemW = (KscreenW - (self.columns+1)*ImageJianXi)/self.columns;
    //计算xy轴的坐标
    CGFloat x = count%self.columns*itemW +ImageJianXi *(count%self.columns+1);
    CGFloat y = count/self.columns*_height +ImageJianXi *(count/self.columns+1);
    
    return CGRectMake(x, y, itemW, _height);
}

//根据数据计算高度
-(CGFloat)heightForCount:(NSInteger)count{
    
    //计算行数
    long row = count/self.columns;
    
    if (count%self.columns != 0) {

        row++;
    }
    
    CGFloat height = _height * row +ImageJianXi*(row+1);
    
    return height;
    
}




@end
