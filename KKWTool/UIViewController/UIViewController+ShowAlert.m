//
//  UIViewController+ShowAlert.m
//  ZSEthersWallet
//
//  Created by L on 2018/1/9.
//  Copyright © 2018年 lkl. All rights reserved.
//

#import "UIViewController+ShowAlert.h"

@implementation UIViewController (ShowAlert)

- (UIViewController *)topViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)showAlertWithTitle:(NSString *)title Message:(NSString *)msg clicked:(void(^)(NSString *))clicked {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Enter password of wallet",nil);
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Alert_OK",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *passwordfiled = alertController.textFields[0];
        if (clicked) {
            clicked(passwordfiled.text);
        }
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg cancelTitle:(NSString *)cancelTitle cancelClicked:(void(^)(void))cancelClicked confirmTitle:(NSString *)confirmTitle confirmClicked:(void(^)(void))confirmClicked {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelClicked) {
            cancelClicked();
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirmClicked) {
            confirmClicked();
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmClicked:(void(^)(void))confirmClicked {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmClicked) {
            confirmClicked();
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)currentViewController{
    
    UIViewController *(^getCurrentVC)(void) = ^{
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal) {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tempWindow in windows) {
                if (tempWindow.windowLevel == UIWindowLevelNormal) {
                    window = tempWindow;
                    break;
                }
            }
        }
        // 2. get current View Controller
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        UIViewController *currentController = nil;
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            currentController = nextResponder;
        } else {
            currentController = window.rootViewController;
        }
        return currentController;
    };
    
    if([NSThread currentThread].isMainThread){
        return getCurrentVC();
    }else{
        UIViewController *__block currentController = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            currentController = getCurrentVC();
        });
        return currentController;
    }
}

@end
