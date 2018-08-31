//
//  UIView+Const.h
//  creditor
//
//  Created by john on 2017/9/19.
//  Copyright © 2017年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Const)

+ (BOOL)isPhoneX;

+ (CGFloat)statusBarHeight;

+ (CGFloat)navigationBarHeight;

+ (CGFloat)topHeight;

+ (CGFloat)tabbarHeight;

+ (CGFloat)safeBottomAreaHeight;

+ (CGFloat)safeTopAreaHeight;

+ (CGFloat)separateLineHeight;

/**
 边框厚度

 @return <#return value description#>
 */
+ (CGFloat)borderWidth;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)scaleTo750;

@end
