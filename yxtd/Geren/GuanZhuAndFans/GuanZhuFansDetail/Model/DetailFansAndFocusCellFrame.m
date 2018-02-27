//
//  DetailFansAndFocusCellFrame.m
//  yxtd
//
//  Created by qin on 2018/2/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailFansAndFocusCellFrame.h"

#define padding 10
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

//myfamily
#define myFamilyHeaderHeight 80
#define makeBookButtonHeight 60

#define imageTag 2000


#define nameFont [UIFont systemFontOfSize:15]
#define shuoshuotextFont [UIFont systemFontOfSize:14]
#define replytextFont [UIFont systemFontOfSize:14]


@interface DetailFansAndFocusCellFrame ()
{

    CGFloat nameLabelX;
}


@end


@implementation DetailFansAndFocusCellFrame


-(void)setModel:(DetailFansAndFocusModel *)model
{
    
    _model=model;

    CGSize nameLabelSize = [self sizeWithString:model.nickname font:nameFont maxSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
    CGFloat nameLabelY = padding;
    CGFloat nameLabelWidth = nameLabelSize.width;
    CGFloat nameLabelHeight = nameLabelSize.height;
    self.nameF = CGRectMake(nameLabelX, nameLabelY, nameLabelWidth, nameLabelHeight);
    
  
}

//先执行DetailArrayModel后执行DetailFansAndFocusModel，所以位置设置要多注意
-(void)setModelGroup:(DetailArrayModel *)modelGroup{
    
    _modelGroup=modelGroup;
    
    //iconF头像
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewWidth = 40;
    CGFloat iconViewHeight = 40;
    self.iconF = CGRectMake(iconViewX, iconViewY, iconViewWidth, iconViewHeight);
    
    //nameF昵称
    //因为先执行所以在这里先把位置赋值进行传递
    nameLabelX = CGRectGetMaxX(self.iconF) + padding;
    
    
    //时间戳
    CGFloat timeLabelWidth = 50;
    CGFloat timeLabelHeight = 15;
    CGFloat timeLabelX = KscreenW - padding - timeLabelWidth;
    CGFloat timeLabelY = iconViewY;
    self.timeF = CGRectMake(timeLabelX, timeLabelY, timeLabelWidth, timeLabelHeight);
    
    //发布时间前面竖线
    CGFloat lineHeight = 11;
    CGFloat lineY = padding+2;
    CGFloat lineX=timeLabelX-padding/2;
    self.lineF=CGRectMake(lineX,lineY, 1,lineHeight);
    
    //城市定位
    CGFloat cityLabelWidth = 25;
    CGFloat cityLabelHeight = 15;
    CGFloat cityX=lineX-padding/2-cityLabelWidth;
    self.cityF=CGRectMake(cityX, iconViewY, cityLabelWidth, cityLabelHeight);
    
    //地图标志
    CGFloat mapLogoWidth = 10;
    CGFloat mapLogoHeight = 11;
    CGFloat mapLogoX=cityX-mapLogoWidth;
     CGFloat mapLogoY =lineY ;
    self.mapLogoF=CGRectMake(mapLogoX, mapLogoY, mapLogoWidth, mapLogoHeight);
    

    //shuoshuotextF正文
    CGFloat shuoshuotextLabelX = nameLabelX;
    CGFloat shuoshuotextLabelY = padding*3;
    CGSize shuoshuotextLabelSize = [self sizeWithString:self.modelGroup.content[0] font:shuoshuotextFont maxSize:CGSizeMake(screenWidth - nameLabelX - padding, MAXFLOAT)];
    CGFloat shuoshuotextLabelWidth = shuoshuotextLabelSize.width;
    CGFloat shuoshuotextLabelHeight = shuoshuotextLabelSize.height;
    self.shuoshuotextF = CGRectMake(shuoshuotextLabelX, shuoshuotextLabelY, shuoshuotextLabelWidth, shuoshuotextLabelHeight);
    
    
    //picturesF发的图片
    if ([self.modelGroup.img_url count]) {
        CGFloat picturesViewWidth;
        CGFloat picturesViewHeight;
        if ([self.modelGroup.img_url count] == 1) {   //图片会大点
            picturesViewWidth = 120;
            picturesViewHeight = 120;
        }
        else
        {
            picturesViewWidth = 70;
            picturesViewHeight = 70;
            
        }
        for (int i = 0; i < [self.modelGroup.img_url count]; i++) {
            CGFloat picturesViewX = nameLabelX + (i%3)*(picturesViewWidth + padding);
            CGFloat picturesViewY = CGRectGetMaxY(self.shuoshuotextF) + padding + (padding + picturesViewHeight)*(i/3);
            CGRect pictureF = CGRectMake(picturesViewX, picturesViewY, picturesViewWidth, picturesViewHeight);
            [self.picturesF addObject:[NSValue valueWithCGRect:pictureF]];   //NSValue可以封装c/c++类型，让ios数组能够添加
        }
        self.cellHeight = CGRectGetMaxY([(NSValue *)[self.picturesF lastObject] CGRectValue]) + padding;
    }
    else
    {
        self.cellHeight = CGRectGetMaxY(self.shuoshuotextF) + padding;
    }

    
    //评论按钮
    CGFloat replyButtonWidth = 35;
    CGFloat replyButtonHeight = 25;
    CGFloat replyButtonX = screenWidth - padding - replyButtonWidth;
    CGFloat replyButtonY = self.cellHeight;
    
    
    
    self.replyF = CGRectMake(replyButtonX, replyButtonY, replyButtonWidth, replyButtonHeight);
    
    self.cellHeight = CGRectGetMaxY(self.replyF) + padding;
    //评论
    if([self.modelGroup.content count])
    {
        CGFloat replyLabelX = nameLabelX + padding/2;
        for (int i = 0; i < [self.modelGroup.content count]; i++) {
            CGSize replyLabelSize = [self sizeWithString:[self.modelGroup.content objectAtIndex:i] font:replytextFont maxSize:CGSizeMake(screenWidth - 2*padding - nameLabelX, MAXFLOAT)];
            CGFloat replyLabelY = self.cellHeight;
            CGFloat replyLabelWidth = replyLabelSize.width;
            CGFloat replyLabelHeight = replyLabelSize.height;
            self.cellHeight += padding +replyLabelHeight;
            CGRect replyF = CGRectMake(replyLabelX, replyLabelY, replyLabelWidth, replyLabelHeight);
            [self.replysF addObject:[NSValue valueWithCGRect:replyF]];
        }
        
        //评论的背景
        self.cellHeight = CGRectGetMaxY([(NSValue *)[self.replysF lastObject] CGRectValue]) + padding;
        CGFloat replyBackgroundWidth = screenWidth - 1.5*padding -nameLabelX;
        CGFloat replyBackgroundHeight = self.cellHeight - padding*2 - CGRectGetMaxY(self.replyF);
        self.replyBackgroundF = CGRectMake(nameLabelX, CGRectGetMaxY(self.replyF) + padding, replyBackgroundWidth, replyBackgroundHeight);
    }
    
    //点赞栏竖线
    self.cellHeight = CGRectGetMaxY(self.replyBackgroundF) + padding*2;
    CGFloat lineViewY = self.cellHeight;
    CGFloat lineViewX = KscreenW/2;
    CGFloat lineViewHeight = 20;
    self.lineViewF=CGRectMake(lineViewX, lineViewY, 1, lineViewHeight);
    
     self.cellHeight = CGRectGetMaxY(self.lineViewF) + padding;
    
    
    //点赞人数
    CGFloat dianzanNumberWidth = 40;
    CGFloat dianzanNumberHeight = 20;
    CGFloat dianzanNumberY = lineViewY;
    CGFloat dianzanNumberX = lineViewX-SYRealValueWidth(66)-dianzanNumberWidth;
self.dianzanNumberF=CGRectMake(dianzanNumberX, dianzanNumberY, dianzanNumberWidth, dianzanNumberHeight);
    
    //点赞图标
    CGFloat dianzanLogoWidth = 16;
    CGFloat dianzanLogoHeight = 16; self.dianzanLogoF=CGRectMake(CGRectGetMinX(self.dianzanNumberF)-dianzanNumberWidth, dianzanNumberY, dianzanLogoWidth, dianzanLogoHeight);
    
    
    //评论图标
    CGFloat commentImageWidth = 15;
    CGFloat commentImageHeigth = 13;
self.commentImageF=CGRectMake(CGRectGetMaxX(self.lineViewF)+SYRealValueWidth(66), dianzanNumberY, commentImageWidth, commentImageHeigth);
    
    //评论人数
    CGFloat commentNumberWidth = 40;
    CGFloat commentNumberHeight = 20; self.commentNumberF=CGRectMake(CGRectGetMaxX(self.commentImageF)+10, dianzanNumberY, commentNumberWidth, commentNumberHeight);
    
    
    
    
    
    
    self.cellHeight = CGRectGetMaxY(self.lineViewF) + padding;
    
}


-(NSMutableArray *)replysF
{
    if (!_replysF) {
        _replysF = [[NSMutableArray alloc]init];
    }
    return _replysF;
}

-(NSMutableArray *)picturesF
{
    if (!_picturesF) {
        _picturesF = [[NSMutableArray alloc]init];
    }
    return _picturesF;
}



/*  计算文本的高
 @param str   需要计算的文本
 @param font  文本显示的字体
 @param maxSize 文本显示的范围，可以理解为limit
 
 @return 文本占用的真实宽高
 */
-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

@end
