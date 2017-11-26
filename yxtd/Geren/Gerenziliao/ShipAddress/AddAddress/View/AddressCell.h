//
//  AddressCell.h
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;

@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldLeftMargin;

+ (instancetype)getAddAddressCellWithTableView:(UITableView *)tableView;


@end
