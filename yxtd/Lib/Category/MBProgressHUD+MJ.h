//
//  MBProgressHUD+MJ.h
//
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+ (void)showTextHUDAddedTo:(UIView *)vi Msg:(NSString *)str animated:(BOOL)bo;
@end
