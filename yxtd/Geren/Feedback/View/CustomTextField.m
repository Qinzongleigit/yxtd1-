//
//  CustomTextField.m
//  yxtd
//
//  Created by qin on 2018/1/10.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField


// 控制placeHolder的位置，左右缩20，但是光标位置不变
 -(CGRect)placeholderRectForBounds:(CGRect)bounds
 {
 CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -25, bounds.size.height);//更好理解些
 return inset;
 }

//修改文本展示区域
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}


// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变  
-(CGRect)editingRectForBounds:(CGRect)bounds{
    
    CGRect inset=CGRectMake(bounds.origin.x+10,bounds.origin.y,bounds.size.width-25, bounds.size.height);
    return inset;
}

@end
