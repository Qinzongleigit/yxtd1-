//
//  AddAddressVC.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "AddAddressVC.h"
#import "AddressCell.h"

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@interface AddAddressVC ()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>


@property (nonatomic, strong) NSArray *cellLabelArr;

@property (nonatomic, weak) UIPickerView *picker;

@property (nonatomic, strong) NSDictionary *areaDic;

@property (nonatomic, strong) NSArray *province;

@property (nonatomic, strong) NSArray *city;

@property (nonatomic, strong) NSArray *district;

@property (nonatomic, copy) NSString *selectedProvince;

@property (nonatomic, weak) UITextField *pikerAddressTF;

@property (nonatomic, copy) NSString *sheng;

@property (nonatomic, copy) NSString *shi;

@property (nonatomic, copy) NSString *xian;

@property (nonatomic, weak) UISwitch *accessorySwitch;

@property (nonatomic, weak) UITextView *addressTextView;

@property (nonatomic, weak) UITextField *recverName;

@property (nonatomic, weak) UITextField *recverNumber;



@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.cellLabelArr = @[@"收货人", @"手机号码", @"省 市 区", @"详细地址", @"设置为默认地址"];
    
    self.tableView.allowsSelection = NO;
    
    [self setExtraCellLineHidden:self.tableView];
    
    
}


- (UIPickerView *)setUpAddressPiker
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [_areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[sortedArray count]; i++) {
        
        NSString *index = [sortedArray objectAtIndex:i];
        
        NSArray *tmp = [[_areaDic objectForKey: index] allKeys];
        
        [provinceTmp addObject: [tmp objectAtIndex:0]];
        
    }
    
    _province = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [_province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[_areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    _city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [_city objectAtIndex: 0];
    _district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    
    
    UIPickerView *piker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, KscreenW, 240)];
    _picker = piker;
    _picker.dataSource = self;
    _picker.delegate = self;
    _picker.showsSelectionIndicator = YES;
    [_picker selectRow: 0 inComponent: 0 animated: YES];
    
    _selectedProvince = [_province objectAtIndex: 0];
    
    return piker;
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressCell *cell = [AddressCell getAddAddressCellWithTableView:tableView];
    
    cell.cellLabel.text = _cellLabelArr[indexPath.row];
    
    if (indexPath.row == 0)
    {
        
        cell.cellTextField.placeholder = _cellLabelArr[indexPath.row];
        
        _recverName = cell.cellTextField;
        
    }
    
    if (indexPath.row == 1)
    {
        cell.cellTextField.placeholder = _cellLabelArr[indexPath.row];
        
        cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        
        _recverNumber = cell.cellTextField;
        
        _recverNumber.delegate=self;
    }
    
    if (indexPath.row == 2)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.pikerAddressTF = cell.cellTextField;
        
        cell.cellTextField.text = @"请选择";
        
        cell.cellTextField.delegate = self;
        
        cell.cellTextField.tintColor = [UIColor clearColor];;
        
        cell.cellTextField.inputView = [self setUpAddressPiker];
        
    }
    if (indexPath.row == 3)
    {
        
        cell.cellTextField.hidden = YES;
        
        cell.addressTextView.hidden = NO;
        
        
        //  cell.addressTextView.text=@"我的商品";
        
        _addressTextView = cell.addressTextView;
        
        
        
        
    }
    
    if(indexPath.row == 4)
    {
        cell.labelWidth.constant = 110;
        
        cell.cellTextField.hidden = YES;
        
        UISwitch *accessorySwitch = [[UISwitch alloc] init];
        
        _accessorySwitch = accessorySwitch;
        
        accessorySwitch.on = NO;
        
        cell.accessoryView = accessorySwitch;
        
    }
    
    return cell;
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string  isEqualToString:@"\n"]) {
        return YES;
    }
    
    if (_recverNumber==textField) {
        
        NSString *toBeString=[_recverNumber.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length>11) {
            textField.text = [toBeString substringToIndex:11];
            
            return NO;
            
        }
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _pikerAddressTF.text = [self showAddressInCell];
    
    return YES;
}

//隐藏多余的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) return 120;
    
    return 44;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}

#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        
        return [_province count];
        
    }
    else if (component == CITY_COMPONENT) {
        
        return [_city count];
        
    }
    else {
        
        return [_district count];
        
    }
}

#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT)
    {
        return [_province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT)
    {
        return [_city objectAtIndex: row];
    }
    else
    {
        return [_district objectAtIndex: row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT)
    {
        _selectedProvince = [_province objectAtIndex: row];
        
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_areaDic objectForKey: [NSString stringWithFormat:@"%ld", row]]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _selectedProvince]];
        
        NSArray *cityArray = [dic allKeys];
        
        
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2)
                                {
                                    
                                    if ([obj1 integerValue] > [obj2 integerValue])
                                    {
                                        return (NSComparisonResult)NSOrderedDescending;//递减
                                    }
                                    
                                    if ([obj1 integerValue] < [obj2 integerValue])
                                    {
                                        return (NSComparisonResult)NSOrderedAscending;//上升
                                    }
                                    return (NSComparisonResult)NSOrderedSame;
                                }];
        
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[sortedArray count]; i++)
        {
            NSString *index = [sortedArray objectAtIndex:i];
            
            NSArray *temp = [[dic objectForKey: index] allKeys];
            
            [array addObject: [temp objectAtIndex:0]];
        }
        
        _city = [[NSArray alloc] initWithArray: array];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        
        _district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [_city objectAtIndex: 0]]];
        
        [_picker reloadComponent: CITY_COMPONENT];
        
        [_picker reloadComponent: DISTRICT_COMPONENT];
        
        [_picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        
        [_picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        
    }
    else if (component == CITY_COMPONENT)
    {
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", [_province indexOfObject: _selectedProvince]];
        
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_areaDic objectForKey: provinceIndex]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _selectedProvince]];
        
        NSArray *dicKeyArray = [dic allKeys];
        
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2)
                                {
                                    if ([obj1 integerValue] > [obj2 integerValue])
                                    {
                                        return (NSComparisonResult)NSOrderedDescending;
                                    }
                                    
                                    if ([obj1 integerValue] < [obj2 integerValue])
                                    {
                                        return (NSComparisonResult)NSOrderedAscending;
                                    }
                                    return (NSComparisonResult)NSOrderedSame;
                                }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        _district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        
        [_picker reloadComponent: DISTRICT_COMPONENT];
        
        [_picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
    }
    
    _pikerAddressTF.text = [self showAddressInCell];
    
}

- (NSString *)showAddressInCell
{
    NSInteger provinceIndex = [_picker selectedRowInComponent: PROVINCE_COMPONENT];
    
    NSInteger cityIndex = [_picker selectedRowInComponent: CITY_COMPONENT];
    
    NSInteger districtIndex = [_picker selectedRowInComponent: DISTRICT_COMPONENT];
    
    NSString *provinceStr = [_province objectAtIndex: provinceIndex];
    _sheng = provinceStr;
    
    NSString *cityStr = [_city objectAtIndex: cityIndex];
    _shi = cityStr;
    
    NSString *districtStr = [_district objectAtIndex:districtIndex];
    _xian = districtStr;
    
    NSString *showMsg = [NSString stringWithFormat: @"%@ %@ %@", provinceStr, cityStr, districtStr];
    
    return showMsg;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return KscreenW / 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT)
    {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, KscreenW / 3, 35)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [_province objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:15];
        
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT)
    {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, KscreenW / 3, 35)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [_city objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:15];
        
        myView.backgroundColor = [UIColor clearColor];
    }
    else
    {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, KscreenW / 3, 35)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [_district objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:15];
        
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}



@end
