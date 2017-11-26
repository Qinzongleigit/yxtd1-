//
//  AddressCell.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell()<UITextViewDelegate>

@property (nonatomic,weak) UILabel *plaLabel;


@end

@implementation AddressCell

static NSString *ID = @"addAddressCell";

+ (instancetype)getAddAddressCellWithTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:ID];
    
    return [tableView dequeueReusableCellWithIdentifier:ID];
}


- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.addressTextView.delegate = self;
    
    
    NSLog(@"--------%@",self.addressTextView.text);
    
    [self makePlaceholderLable:@"若虚拟商品,请填写账号信息" superView:self.addressTextView];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    NSLog(@"------%@",self.addressTextView.text);
    
    if(self.addressTextView.text.length > 0 )
    {
        self.plaLabel.hidden = YES;
        
    }else{
        
        self.plaLabel.hidden = NO;
    }
    
    
    
    
}


#pragma mark   创建一个提示Label
- (void)makePlaceholderLable:(NSString *)message superView:(UIView *)superView
{
    [self.plaLabel removeFromSuperview];
    
    UILabel *plaLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 5, superView.width, 21)];
    
    self.plaLabel = plaLabel;
    
    plaLabel.backgroundColor = [UIColor clearColor];
    
    plaLabel.text = message;
    
    plaLabel.font = [UIFont systemFontOfSize:14];
    
    plaLabel.textColor = [UIColor colorWithHexString:@"d3d3d3" alpha:1];
    
    [superView addSubview:plaLabel];
}


#pragma mark   textView代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    if(self.addressTextView.text.length > 0 )
    {
        self.plaLabel.hidden = YES;
        
    }else{
        
        self.plaLabel.hidden = NO;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    NSLog(@"------%@",self.addressTextView.text);
    
    if(self.addressTextView.text.length > 0 )
    {
        self.plaLabel.hidden = YES;
        
    }else{
        
        self.plaLabel.hidden = NO;
    }
    
    return YES;
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
