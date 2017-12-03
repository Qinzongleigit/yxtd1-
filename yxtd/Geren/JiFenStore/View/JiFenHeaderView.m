//
//  JiFenHeaderView.m
//  yxtd
//
//  Created by qin on 2017/12/1.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiFenHeaderView.h"

@interface JiFenHeaderView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIImageView*headeImageView;

@property (nonatomic,strong) UIButton*leftBt;

@property (nonatomic,strong) UIButton*rightBt;
@property (nonatomic,strong) UILabel*jifenTitle;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) NSArray* proTitleList;
@property (nonatomic,strong) NSArray* proTimeList;
@end

@implementation JiFenHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self headerUI];
    }
    
    return self;
}

#pragma mark -创建头部视图
-(void)headerUI{
    
    UIImageView*headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, self.height+20)];
    headerImageView.backgroundColor=[UIColor grayColor];
    [self addSubview:headerImageView];
    
    UIButton*leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBt=leftBt;
    [leftBt setBackgroundImage:[UIImage imageWithoriginName:@"leftLoginImage"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(leftBtBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBt];
    
    
    UIButton*rightBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBt=rightBt;
    [rightBt setBackgroundImage:[UIImage imageWithoriginName:@"wenhao_Image"] forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(jifenrightBt) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBt];
    
    UILabel*jifenTitle=[[UILabel alloc] init];
    jifenTitle.text=@"积分商城";
    self.jifenTitle=jifenTitle;
    jifenTitle.font=[UIFont systemFontOfSize:15];
    [jifenTitle setTextColor:[UIColor whiteColor]];
    [self addSubview:jifenTitle];
    
    
    // 选择框
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 320, 40)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self addSubview:pickerView];
    
    _proTimeList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _proTitleList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    
    
    
    
}

#pragma mark -坐标
-(void)layoutSubviews{
    
    
    [self.leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(32);
        
    }];
    
    [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.leftBt);
        make.right.equalTo(self).offset(-15);
    }];
    
    [self.jifenTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.leftBt);
    }];
    
}


#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_proTitleList count];
    }
    
    return [_proTimeList count];
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 1) {
        return 40;
    }
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString  *_proNameStr = [_proTitleList objectAtIndex:row];
        NSLog(@"nameStr=%@",_proNameStr);
    } else {
        NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
        NSLog(@"_proTimeStr=%@",_proTimeStr);
    }
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_proTitleList objectAtIndex:row];
    } else {
        return [_proTimeList objectAtIndex:row];
        
    }
}


-(void)leftBtBack{
    
    self.gotoBack();
    
}

-(void)jifenrightBt{
    
    self.jifenRight();
}


@end
