//
//  UIView+Category.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Complete)(void);

CGRect CGRectScaleMake(CGFloat x ,CGFloat y , CGFloat width,CGFloat height);
CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Category)

@end

@interface UIView (MotionEffect)
- (void)addCenterMotionEffectsXYWithOffset:(CGFloat)offset;
@end

@interface UIView (Shake)
/**
 *  实现UIView抖动效果
 */
- (void) shakeAnimation;
@end

@interface UIView (Animation)
/**
 *  实现UIView弹出效果
 */
- (void) bounceAnimation;
//- (void) showAnimation;
//- (void) moveToRightItemComplete:(Complete)complete;
@end

@interface UIView (Screenshot)
/**
 *  截图
 *
 *  @return 截图后的UIImage对象
 */
- (UIImage *)screenshot;
/**
 *  截图
 *
 *  @param contentOffset 内容偏移
 *
 *  @return 截图后的UIImage对象
 */
- (UIImage *)screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;
/**
 *  截图
 *
 *  @param frame 在某个区域内
 *
 *  @return 截图后的UIImage对象
 */
- (UIImage *)screenshotInFrame:(CGRect)frame;
@end

@interface UIView (toost)

/**
 *  提示框（默认时长2s，默认位置居下）
 *
 *  @param message 提示信息文本
 */
- (void)displayMessage:(NSString *)message;

/**
 *  提示框
 *
 *  @param message  提示信息文本
 *  @param interval 显示时长（单位：s）
 *  @param position 显示位置（top、bottom、center）
 */
- (void)displayMessage:(NSString *)message duration:(CGFloat)interval position:(id)position;

/**
 <#Description#>

 @param error <#error description#>
 */
- (void)displayError:(NSString *)error;

/**
 <#Description#>

 @param error <#error description#>
 @param interval <#interval description#>
 */
- (void)displayError:(NSString *)error duration:(CGFloat)interval;

@end
