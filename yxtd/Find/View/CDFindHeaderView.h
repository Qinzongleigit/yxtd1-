//
//  CDFindHeaderView.h
//  yxtd
//
//  Created by qin on 2017/9/22.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

//（回调）声明属性
@protocol DataBackProcotol <NSObject>


//方法
-(void)DataBack:(int) index;



@end

@interface CDFindHeaderView : UIView


@property (strong,nonatomic) id<DataBackProcotol> delegete;


-(instancetype)initWithFrame:(CGRect)frame NSArray:(NSArray*)array;

@end
