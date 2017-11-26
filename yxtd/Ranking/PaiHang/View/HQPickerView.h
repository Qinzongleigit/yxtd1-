//
//  HQPickerView.h
//  HQPickerView
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 judian. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理
@protocol HQPickerViewDelegate <NSObject>

- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text;

@end

@interface HQPickerView : UIView

@property(nonatomic,strong) void(^tabHiddenBt)(void);


@property (nonatomic, strong) NSArray *customArr;

@property (nonatomic, weak) id <HQPickerViewDelegate> delegate;

@end
