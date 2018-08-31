//
//  UIView+Const.m
//  creditor
//
//  Created by john on 2017/9/19.
//  Copyright © 2017年 Jney. All rights reserved.
//

#import "UIView+Const.h"
#import <sys/utsname.h>

@implementation UIView (Const)

+ (BOOL)isPhoneX{
    return CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0;
}

+ (CGFloat)statusBarHeight{
    if([self isPhoneX]){
        return 44.0;
    }else{
        return 20.0;
    }
}

+ (CGFloat)navigationBarHeight{
    return 44.0;
}

+ (CGFloat)topHeight{
    return [UIView isPhoneX] ? 88.0 :64.0;
}

+ (CGFloat)tabbarHeight{
    if([self isPhoneX]){
        return 83.0;
    }else{
        return 49.0;
    }
}

+ (CGFloat)safeBottomAreaHeight{
    return [UIView isPhoneX] ? 34.0 :0.0;
}

+ (CGFloat)safeTopAreaHeight{
    return [UIView isPhoneX] ? 24.0 :0.0;
}

+ (CGFloat)separateLineHeight{
    return 0.5;///[UIScreen mainScreen].scale;
}

+ (CGFloat)borderWidth{
    return 0.5/[UIScreen mainScreen].scale;
}

+ (CGFloat)screenWidth{
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+ (CGFloat)screenHeight{
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

+ (CGFloat)scaleTo750{
    static CGFloat scale = 0;
    if(scale != 0){
        return scale;
    }else{
        if(CGRectGetWidth([UIScreen mainScreen].bounds) < 375){
            scale = CGRectGetWidth([UIScreen mainScreen].bounds)/375.0;
        }else{
            scale = 1;
        }
    }
    return scale;
}
@end
